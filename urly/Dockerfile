FROM python:3.9-alpine
WORKDIR /code
RUN pip install bottle redis
ADD app.py /code
EXPOSE 8080
CMD ["python", "app.py"]
