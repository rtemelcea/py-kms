FROM alpine:3.12

ENV IP		0.0.0.0
ENV PORT		1688
ENV EPID		""
ENV LCID		1033
ENV CLIENT_COUNT	26
ENV ACTIVATION_INTERVAL	525601
ENV RENEWAL_INTERVAL	525601
ENV HWID		"RANDOM"
ENV LOGLEVEL	INFO
ENV LOGFILE		/var/log/pykms_logserver.log
ENV LOGSIZE		""

RUN apk add --no-cache --update \
	bash \
	git \
	py3-argparse \
	py3-flask \
	py3-pygments \
	python3-tkinter \
	sqlite-libs \
	py3-pip && \
    pip3 install peewee tzlocal && \
    git clone https://github.com/SystemRage/py-kms/ /tmp/py-kms && \
    mv /tmp/py-kms/py-kms /home/ && \
    rm -rf /tmp/py-kms && \
    apk del git

WORKDIR /home/py-kms

EXPOSE ${PORT}/tcp

ENTRYPOINT /usr/bin/python3 pykms_Server.py ${IP} ${PORT} -l ${LCID} -c ${CLIENT_COUNT} -a ${ACTIVATION_INTERVAL} -r ${RENEWAL_INTERVAL} -w ${HWID} -V ${LOGLEVEL} -F ${LOGFILE}
