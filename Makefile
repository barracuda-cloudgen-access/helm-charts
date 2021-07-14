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
	helm dependency update ./charts/*

helm-docs:
	docker run --rm --volume "$$(pwd):/helm-docs" \
		-u $$(id -u) jnorwood/helm-docs:v1.5.0

lint: helm-deps
	helm lint ./charts/*
	act -j linter --env-file <(echo "RUN_LOCAL=true")

# Use to test the deployment of the resources
helm-test:
	@kind create cluster --name=cga-proxy-test
	$(MAKE) helm-deps
	helm install cga-proxy-test ./charts/cga-proxy --set=http-test.enabled=true
	sleep 5
	kubectl get pods
	echo -e "\nNOTE:\n  The orchestrator pod will fail with 'CreateContainerConfigError' due to missing enrollment key"
	echo -e "\nTo update configuration run:\n   helm upgrade cga-proxy-test ./charts/cga-proxy --set=http-test.enabled=true"
	echo -e "\nTo remove the cluster run:\n   kind delete cluster --name=cga-proxy-test"
