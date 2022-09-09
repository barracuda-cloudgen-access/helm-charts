### Make config

.ONESHELL:
SHELL = bash
.SHELLFLAGS = -eu -c
.PHONY: gh-changelog gh-pages-readme-sync helm-deps lint

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

helm-deps:
	find ./charts/ -maxdepth 1 -mindepth 1 -type d -print0 \
		-exec helm dependency update {} \;

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
