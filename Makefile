CUID=$$(id -u) # current UID
DOCKER_IMG_TF="hashicorp/terraform:0.15.0"
DOCKER_IMG_ANS="ansible:temp"

.PHONY: docker_build \
		tf_prep \
		genpw \
		test

docker_build: # build docker images used by commands
	docker build -t $(DOCKER_IMG_ANS) ./docker/ansible

tf_prep:
	docker run --rm \
		-v $(PWD):/_src \
		-w /_src/ansible \
		--entrypoint "" \
		$(DOCKER_IMG_ANS) sh -c "ansible-playbook ./tf_prep.yml -i 'localhost,' -c local -v -e \"_cuid=$(CUID)\"" && \
	$(PWD)/etc/reset_null_res.sh

genpw:
	cat /dev/urandom | tr -dc "a-zA-Z0-9@.^_" | fold -w $${LEN:=24} | head -n 1
