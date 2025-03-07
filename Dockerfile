# Use specific version of nvidia cuda image
FROM megaease/base:cuda11.8.0-v0.0.1

# Install Python dependencies (Worker Template)
COPY requirements.txt /requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip \
    python3.11 -m pip install --upgrade pip && \
    python3.11 -m pip install -r /requirements.txt --no-cache-dir && \
    rm /requirements.txt

# Copy and run script to fetch models
COPY . /usr/src/app

WORKDIR /usr/src/app

# Load models to image
RUN python3.11 src/build.py

CMD ["python3.11", "-u", "src/main.py"]