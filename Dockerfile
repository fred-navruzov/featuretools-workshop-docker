FROM ubuntu:18.04

MAINTAINER Fred Navruzov

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

WORKDIR /home

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y git

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh
ENV PATH /opt/conda/bin:$PATH

RUN git clone https://github.com/fred-navruzov/featuretools-workshop

#RUN conda install nb_conda jupyter pandas numpy scipy cython matplotlib seaborn scikit-learn joblib --quiet --dry-run
RUN pip install pandas-profiling
RUN pip install featuretools
RUN pip install lightgbm

WORKDIR /home/featuretools-workshop

RUN echo "Go to http://0.0.0.0:8888/tree/ and use the token below"

ENTRYPOINT jupyter notebook --ip 0.0.0.0 --no-browser --allow-root