FROM python:3.9.7-alpine

# Disable output buffering
# http://stackoverflow.com/questions/107705/ddg#107717
ENV PYTHONUNBUFFERED 1

# Install dependencies and create project directory
WORKDIR /opt/services/app/src

COPY requirements.txt .
RUN pip install \
    --no-cache-dir \
    --requirement requirements.txt

# Create a group and user
RUN addgroup -g 101 -S django && \
    adduser -u 101 -S django -G django -D -h /opt/services/app && \
    chown django:django /opt/services/app/src

# Tell docker that all future commands should run as the appuser user
USER django

# Create minimal django project
RUN django-admin startproject djangoapp .

# copy our project code
COPY . .

# expose the port 8000
EXPOSE 8000

# define the default command to run when starting the container
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]
