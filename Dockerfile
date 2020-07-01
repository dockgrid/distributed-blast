FROM ubuntu:19.10
RUN apt-get update && apt-get -y install ncbi-blast+ htop wget curl
RUN mkdir -p pipeline

COPY run.sh /pipeline
WORKDIR /pipeline

ADD http://ftp.ncbi.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz db/
RUN tar -zxvf db/16S_ribosomal_RNA.tar.gz -C db/
ENTRYPOINT ["/bin/bash", "/pipeline/run.sh"]
