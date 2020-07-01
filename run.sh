#!/bin/bash
set -e
if [[ $1 == "" ]]
  then
    echo "Missing FASTA url"
  exit 1
fi

echo "[1/4] Downloading sample $1"
wget -O sample.fa.gz $1
gzip -d sample.fa.gz

echo "[2/4] Runing blast against 16S_ribosomal_RNA NCBI database"
blastn -db db/16S_ribosomal_RNA -query sample.fa $BLAST_PARAMETERS | tee blast.out

echo "Compressing result"
tar -zcvf blast.tar.gz blast.out

echo "[4/4] Uploading result back to dockgrid"
curl --request PUT --upload-file blast.tar.gz $DOCKGRID_RESULT_URL
exit 0
