FROM ubuntu:latest

RUN useradd -ms /bin/bash user

WORKDIR /usr/src/app

COPY  ./src /usr/src/app/

RUN apt update 

RUN apt install python3 -y \
    python3-pip \
    net-tools \
    iputils-ping

USER user

RUN python3 -m pip install fastapi \
    uvicorn

#CMD [ "python3", "-m", "uvicorn", "main:app", "--host", "172.17.0.2", "--port", "6080"] 
CMD ["python3", "-m", "uvicorn", "main:app"]
