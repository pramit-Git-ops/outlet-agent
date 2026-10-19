# Builds the WhatsApp agent from agent-code.zip, so GitHub only needs these two files.
FROM python:3.12-slim
WORKDIR /app
COPY agent-code.zip /tmp/agent-code.zip
RUN python -c "import zipfile; zipfile.ZipFile('/tmp/agent-code.zip').extractall('/tmp/src')" \
 && cp -r /tmp/src/whatsapp-agent/. /app/ \
 && rm -rf /tmp/src /tmp/agent-code.zip
RUN pip install --no-cache-dir -r requirements.txt
ENV PORT=8000
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT} --workers 1"]
