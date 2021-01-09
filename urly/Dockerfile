FROM python:3.9-alpine
LABEL org.opencontainers.image.source https://github.com/addreas/homelab
WORKDIR /code
RUN pip install bottle redis
ADD app.py /code
EXPOSE 8080
CMD ["python", "app.py"]
