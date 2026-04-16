# Local Voice Transcription with Whisper and LLM Post-Processing

![learnwithparam.com](https://www.learnwithparam.com/ai-bootcamp/opengraph-image)

Record audio in the browser, transcribe it locally with Faster-Whisper, and polish the text with an LLM (Ollama, LM Studio, or any OpenAI-compatible endpoint). Full-stack: FastAPI backend, React/Vite frontend, runs offline-first on your own machine.

> Start learning at [learnwithparam.com](https://learnwithparam.com). Regional pricing available with discounts of up to 60%.

## What You'll Learn

- Capture microphone audio in the browser with the MediaRecorder API
- Stream audio uploads to a FastAPI backend with multipart file handling
- Run Whisper locally with `faster-whisper` for speech-to-text on CPU or GPU
- Use any OpenAI-compatible LLM (Ollama, LM Studio, OpenAI) to clean transcripts
- Wire a React + Vite frontend to a Python backend with CORS-aware fetch calls
- Ship an offline-first AI app that works without sending audio to the cloud

## Tech Stack

- **Backend:** Python 3.12, FastAPI, Uvicorn, faster-whisper, OpenAI-compatible client
- **Frontend:** React 19, Vite 7, TypeScript, lucide-react icons
- **LLM runtime:** Ollama (default), LM Studio, or OpenAI API
- **Tooling:** uv for Python deps, npm for JS deps

## Getting Started

### Prerequisites

- Python 3.12+, Node.js 20+
- [uv](https://docs.astral.sh/uv/) and npm
- An LLM server: [Ollama](https://ollama.com/) (pull a model: `ollama pull gemma3:4b`) or LM Studio, or an OpenAI API key

### Quick Start

```bash
# One command to set up both apps
make setup

# Then run in two terminals:
make backend        # starts FastAPI at :8000
make frontend       # starts Vite at :3000
```

Open [http://localhost:3000](http://localhost:3000).

### With Docker

```bash
make build
make up
make logs
make down
```

## Challenges

Work through these incrementally to build the full app:

1. **Browser Recording** - Use MediaRecorder to capture webm audio chunks
2. **Upload Endpoint** - FastAPI route that accepts multipart uploads and saves a temp file
3. **Local Whisper** - Load `faster-whisper` with device auto-detect and transcribe the upload
4. **LLM Cleanup** - Send the raw transcript to an OpenAI-compatible LLM with a cleanup system prompt
5. **Provider Switching** - Swap Ollama for LM Studio or OpenAI via `.env` without changing code
6. **Custom System Prompts** - Let the user edit the cleanup prompt from the UI
7. **Copy to Clipboard** - One-click copy of both raw and cleaned text
8. **Streaming Transcripts** - Stream partial results back as Whisper processes longer audio

## Project Layout

```
voice-transcription-whisper/
├── backend/           FastAPI + Whisper + LLM cleanup
│   ├── app.py
│   ├── transcription.py
│   ├── system_prompt.txt
│   └── pyproject.toml
├── frontend/          React + Vite recorder UI
│   ├── src/
│   └── package.json
├── Makefile
├── Dockerfile
└── docker-compose.yml
```

## Makefile Targets

```
make help           Show all available commands
make setup          Install backend and frontend dependencies
make backend        Run only the backend
make frontend       Run only the frontend
make build          Build Docker images
make up             Start containers
make down           Stop containers
make logs           View container logs
make clean          Remove venv, node_modules, and caches
```

## About

Created by [learnwithparam.com](https://learnwithparam.com) for engineers learning AI Engineering through hands-on projects.

Explore more courses at [learnwithparam.com/courses](https://learnwithparam.com/courses).
