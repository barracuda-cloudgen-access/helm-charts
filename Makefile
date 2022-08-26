### Make config

.ONESHELL:
SHELL = bash
.SHELLFLAGS = -eu -c
.PHONY: gh-changelog gh-pages-readme-sync git-clean helm-deps helm-docs lint

### Actions

gh-changelog:
	./misc/get-tag-log-diff.sh

gh-pages-readme-sync:
	git fetch --all
	git checkout gh-pages
	git checkout main README.md
	sed -i 's#./misc/cga-logo.png#https://raw.githubusercontent.com/barracuda-cloudgen-access/helm-charts/main/misc/cga-logo.png#g' README.md
	git add README.md
	git commit -m "Sync gh-pages"
	git push origin gh-pages
	git checkout -

git-clean:
	@if git diff --exit-code; then
		echo -e "\n####### Git is clean\n"
	else
		echo -e "\n####### Git changes detected! Check and commit changes !!!\n"
		exit 1
	fi

helm-deps:
	find ./charts/ -maxdepth 1 -mindepth 1 -type d -print0 \
		-exec helm dependency update {} \;

helm-docs:
	docker run --rm --volume "$$(pwd):/helm-docs" \
		-u $$(id -u) jnorwood/helm-docs:v1.5.0

lint: helm-deps
	helm lint ./charts/*
	act -j linter --env-file <(echo "RUN_LOCAL=true")

# Use to test the deployment of the resources
# make helm-test-cga-proxy ENROLLMENT_TOKEN="${ENROLLMENT_TOKEN}"
helm-test-cga-proxy:
	@./misc/helm-test.sh cga-proxy \
		"${ENROLLMENT_TOKEN}"

# make helm-test-cga-directory-connector ENROLLMENT_TOKEN="${ENROLLMENT_TOKEN}"
helm-test-cga-directory-connector:
	@./misc/helm-test.sh cga-directory-connector \
		"${ENROLLMENT_TOKEN}"

helm-test-clean:
	@./misc/helm-test.sh clean

helm-test-ci:
	@./misc/helm-test.sh ci
