### Make config

.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS = -eu -c
.PHONY: git-clean helm-docs lint

### Actions

git-clean:
	@if git diff --exit-code; then
		echo -e "\n####### Git is clean\n"
	else
		echo -e "\n####### Git changes detected! Check and commit changes !!!\n"
		exit 1
	fi

lint:
	helm dependency update ./charts/*
	helm lint ./charts/*
	act -j linter --env-file <(echo "RUN_LOCAL=true")

helm-docs:
	docker run --rm --volume "$$(pwd):/helm-docs" \
		-u $$(id -u) jnorwood/helm-docs:v1.5.0
