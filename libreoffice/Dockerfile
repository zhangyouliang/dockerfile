FROM ubuntu:16.04

COPY sources.list /etc/apt/sources.list


RUN apt-get update \
    && apt-get install libreoffice  -y \
    && mkdir -p /usr/share/fonts

COPY simsunb.ttf /usr/share/fonts

RUN chmod 644 /usr/share/fonts/simsunb.ttf

# soffice -headless  \
# -invisible -norestore \
# -nodefault -nolockcheck  \
# -nofirststartwizard -convert-to pdf:writer_pdf_Export \
# -outdir /word /word