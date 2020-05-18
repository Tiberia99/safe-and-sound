FROM python:3.6.1-alpine
WORKDIR /project
ADD . /project
ENV FLASK_APP web.py
ENV FLASK_RUN_HOST 0.0.0.0
RUN pip install -r requirements.txt
CMD ["flask", "run"]
