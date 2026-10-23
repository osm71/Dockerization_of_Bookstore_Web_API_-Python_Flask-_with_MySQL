FROM python:3.9-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY bookstore-api.py .
RUN FLASK_APP=bookstore-api.py
RUN FLASK_RUN_HOST=0.0.0.0
EXPOSE 80
CMD python3 ./bookstore-api.py