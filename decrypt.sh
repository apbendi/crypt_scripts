#!/bin/bash

if [[ $# -ne 1 ]] ; then
    echo "Usage: decrypt path/to/encrypted/file.txt.enc"
    exit 1
fi

POSTFIX=".enc"
INPATH=$1

if [[ ! $INPATH =~ ^.+\.enc$ ]] ; then
    echo "Input file does not end with expect extension: $POSTFIX"
    exit 1
fi

OUTPATH=${INPATH%.enc}

if [[ -f $OUTPATH ]] ; then
    echo "A file already exists at: $OUTPATH"
    exit 1
fi

openssl enc -aes-256-cbc -d -in $INPATH -out $OUTPATH
STATUS=$?

if [[ STATUS -ne 0 ]] ; then
    echo "Something went wrong decrypting the file"
    rm $OUTPATH
    exit 1
fi

if [[ ! -f $OUTPATH ]] ; then
    echo "Something went wrong decrypting the file..."
    exit 1
fi

rm $INPATH
