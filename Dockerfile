FROM python:3.7.3-stretch

## Step 1:
# Create a working directory
WORKDIR /app
hello there
## Step 2:
# Copy source code to working directory
COPY . index.html /app/

## Step 3:

# hadolint ignore=DL3013