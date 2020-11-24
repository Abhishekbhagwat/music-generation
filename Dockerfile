FROM python:3.7-slim
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
WORKDIR /app/model/dataset
RUN apt-get update -y && apt-get install -y unzip
RUN bash download_dataset.sh
WORKDIR /app/frontend
RUN agt-get update -y && apt-get install -y npm
RUN npm install
RUN npm run build
EXPOSE 80
WORKDIR /app
RUN mkdir ~/.streamlit
RUN cp config.toml ~/.streamlit/config.toml
RUN cp credentials.toml ~/.streamlit/credentials.toml
WORKDIR /app
ENTRYPOINT ["streamlit", "run"]
CMD ["app.py"]
