# Use a slim base image to reduce image size
FROM python:3.9-slim

# Set the working directory
WORKDIR /app/backend

# Install system dependencies and clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc default-libmysqlclient-dev pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file first to leverage Docker layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose the application port
EXPOSE 5000

# Uncomment and run migrations if needed during the build process
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Define the default command (adjust as necessary)
CMD ["python", "manage.py", "runserver", "0.0.0.0:5000"]
