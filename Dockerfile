# Use the official Ubuntu image
FROM ubuntu

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt and the devops directory into the container
COPY requirements.txt /app
COPY devops /app

# Update apt-get, install Python, pip, and the python3-venv package for virtual environments
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    # Create a virtual environment
    python3 -m venv /app/venv && \
    # Upgrade pip inside the virtual environment
    /app/venv/bin/pip install --upgrade pip && \
    # Install Python dependencies from requirements.txt inside the virtual environment
    /app/venv/bin/pip install -r requirements.txt

# Set the environment variable to use the virtual environment
ENV PATH="/app/venv/bin:$PATH"



# Set the entry point to run the Django app using the virtual environment's Python
ENTRYPOINT ["/app/venv/bin/python3"]

# The command to run Django's development server
CMD ["manage.py", "runserver", "0.0.0.0:8000"]

