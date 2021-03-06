
DOCKER = docker
ROBOT  = robot
YARN   = yarn


## Install
## ------

yarn-install: ## Yarn install
yarn-install:
	$(YARN) install

.PHONY: yarn-install


## Update
## ------

update-yarn: ## Update nodejs packages with yarn
update-yarn:
	$(YARN) upgrade

outdated-js: ## Check outdated npm packages
outdated-js:
	$(YARN) outdated || true

commit: ## Commit with Commitizen command line
commit:
	$(YARN) commit

.PHONY: update-yarn outdated-js commit

## QA
## ------

check: ## Check script with ShellCheck
check:
	$(DOCKER) pull koalaman/shellcheck:stable
	$(DOCKER) run -v "${PWD}:/mnt" koalaman/shellcheck wud.sh

rf-tests: ## Run Robot Framework tests
rf-tests:
	$(ROBOT) tests/RF

.PHONY: check rf-tests

## Deploy
## ------

package: ## Package wud. Arguments: version=1.2.3
package:
	test -n "${version}"  # Fail if version parameter is not set
	@mkdir -p dist
	@cp -f wud.sh dist/wud.sh
	@sed -i 's/__VERSION__/'"${version}"'/g' dist/wud.sh
	@rm -f dist/wud-sh.tar.gz
	@cd dist && tar -czf wud-sh.tar.gz wud.sh

.PHONY: package publish

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help
