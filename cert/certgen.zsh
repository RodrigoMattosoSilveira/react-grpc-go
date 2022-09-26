#!/bin/zsh

CERT_DIR=./cert

# generate ca.key
openssl genrsa -out ${CERT_DIR}/ca.key 4096
# generate certificate
openssl req -new -x509 -key ${CERT_DIR}/ca.key -sha256 -subj "/C=SE/ST=HL/O=Example, INC." -days 365 -out ${CERT_DIR}/ca.cert
# generate the server key
openssl genrsa -out ${CERT_DIR}/server.key 4096
# Generate the csr
openssl req -new -key ${CERT_DIR}/server.key -out ${CERT_DIR}/server.csr -config ${CERT_DIR}/certificate.conf
#
openssl x509 -req -in ${CERT_DIR}/server.csr -CA ${CERT_DIR}/ca.cert -CAkey ${CERT_DIR}/ca.key -CAcreateserial -out ${CERT_DIR}/server.crt -days 365 -sha256 -extfile ${CERT_DIR}/certificate.conf -extensions req_ext