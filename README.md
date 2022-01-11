Test task - PR
==============

For simplicity of usage, I've chosen generating necessary TF code using ansible. For this, ansible image is needed (Dockerfile included). All data is read from `docker-compose.yml` and code generated based on that.

# Prerequisites

- Make
- Docker
- Terraform

# Usage

1. first, ansible docker image is necessary, it can be build by running `make docker_build`
2. check `docker-compose.yml`, no changes are necessary for first `up` run
3. run `make tf_prep` - this will prepare TF generated code + SQL command files
4. run `docker-compose up`
5. in separate shell - cd into terraform and run TF commands
	- `init`
	- `plan|apply`

That will perform all changes for the initial 1st instance defined in `docker-compose.yml`. To test multiple instances, you can uncomment others in this file.

# Notes

- `make tf_prep` has to run before `docker-compose up` (before 1st run and after each update of `docker-compose.yml`)
- DBs can be reset by deleting the `_data` folder before `make tf_prep` run
