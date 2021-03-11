### Make config

.ONESHELL:
SHELL = /bin/bash
.SHELLFLAGS = -eu -c
.PHONY: gh-pages-readme-sync git-clean helm-deps helm-docs lint

### Actions

gh-pages-readme-sync:
	git fetch --all
	git checkout gh-pages
	git checkout main README.md
	git commit -m "Sync README.md"
	git push origin gh-pages
	git checkout -

git-clean:
	@if git diff --exit-code; then
		echo -e "\n####### Git is clean\n"
	else
		echo -e "\n####### Git changes detected! Check and commit changes !!!\n"
		exit 1
	fi

lint: helm-deps
	helm lint ./charts/*
	act -j linter --env-file <(echo "RUN_LOCAL=true")

helm-deps:
	helm dependency update ./charts/*

helm-docs:
	docker run --rm --volume "$$(pwd):/helm-docs" \
		-u $$(id -u) jnorwood/helm-docs:v1.5.0
