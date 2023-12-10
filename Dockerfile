# Stage 1: Build Stage
FROM python:3.8-slim AS builder

WORKDIR /app

COPY requirements.txt .

# Install dependencies separately to leverage Docker cache
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Production Stage
FROM python:3.8-slim

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY . .

CMD ["python", "app.py"]

