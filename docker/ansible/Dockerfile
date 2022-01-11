FROM alpine:latest

# ansible
RUN apk --update add python3 py3-pip openssl ca-certificates jq bash && \
	apk --update add --virtual build-dependencies gcc musl-dev cargo \
				python3-dev libffi-dev openssl-dev build-base  && \
	pip3 install --upgrade pip cffi							&& \
	pip3 install ansible	&& \
	\
	echo "===> Removing package list..."  && \
	apk del build-dependencies			&& \
	rm -rf /var/cache/apk/*			   && \
	\
	echo "===> Adding hosts for convenience..."  && \
	mkdir -p /etc/ansible						&& \
	echo 'localhost ansible_connection=local ansible_user=root' > /etc/ansible/hosts
