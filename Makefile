### Make config

.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS = -eu -c
.PHONY: lint

### Actions

lint:
	helm dependency update ./charts/*
	helm lint ./charts/*
	act -j linter --env-file <(echo "RUN_LOCAL=true")
