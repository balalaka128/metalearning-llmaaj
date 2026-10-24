# Pinoqio judge: a judge that learns from an expert. Solution code lives in judge/.
# Build: docker build -t pinoqio-judge .
# Adapt: docker run --rm -e GEMINI_API_KEY -v "$PWD/in:/input" -v "$PWD/artifacts:/artifacts" pinoqio-judge adapt
# Eval:  docker run --rm -e GEMINI_API_KEY -v "$PWD/in:/input" -v "$PWD/artifacts:/artifacts" -v "$PWD/out:/output" pinoqio-judge eval
FROM python:3.12-slim
WORKDIR /app
COPY judge/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY judge/gemma.py judge/pipeline.py ./
ENTRYPOINT ["python", "/app/pipeline.py"]
