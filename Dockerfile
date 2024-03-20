FROM python:3.11-alpine

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'
ENV EFB_DATA_PATH /data/
ENV EFB_PARAMS ""
ENV EFB_PROFILE "default"
ENV HTTPS_PROXY ""

COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /requirements.txt

RUN apk add --no-cache ffmpeg libmagic tiff openjpeg cairo tzdata openblas ca-certificates \
  py3-numpy py3-olefile py3-cryptography py3-decorator && \
  cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
  apk del tzdata

RUN apk add --no-cache --virtual .build-deps git build-base libffi-dev python3-dev && \
  pip3 install --root-user-action=ignore -r requirements.txt && \
  apk del .build-deps && \
  rm -rf /var/cache/apk/* && \
  rm -rf ~/.cache

ENTRYPOINT ["/entrypoint.sh"]