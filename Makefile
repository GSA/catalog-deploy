MOLECULE_SUITES := \
  software/ckan/catalog/ckan-app \
  software/ckan/inventory \
  software/common/php-fixes

ANSIBLE_PLAYBOOKS := \
  actions/reboot.yml \
  actions/uninstall-fluentd.yml \
  catalog-web.yml \
  catalog-worker.yml \
  catalog.yml \
  common.yml \
  dashboard-web.yml \
  datagov-web.yml \
  inventory.yml \
  jenkins.yml \
  jumpbox.yml \
  newrelic-java.yml \
  newrelic-php.yml \
  pycsw.yml \
  redis.yml \
  site.yml \
  solr.yml

# Create test-molecule-<suite> targets
MOLECULE_SUITE_TARGETS := $(patsubst %,test-molecule-%,$(MOLECULE_SUITES))

# Used for parallelization on CircleCI. See `circleci tests glob`.
# https://circleci.com/docs/2.0/parallelism-faster-jobs/
circleci-glob:
	@echo $(MOLECULE_SUITE_TARGETS) | sed -e 's/ /\n/g'

vendor:
	ansible-galaxy install -p ansible/roles/vendor -r ansible/requirements.yml --force

setup:
	pipenv install --dev

inventory:
	cd ansible && ANSIBLE_INVENTORY_ANY_UNPARSED_IS_FAILED=1 ansible-inventory --graph --inventory inventories/production
	cd ansible && ANSIBLE_INVENTORY_ANY_UNPARSED_IS_FAILED=1 ansible-inventory --graph --inventory inventories/staging

lint: inventory
	cd ansible && ANSIBLE_INVENTORY_ANY_UNPARSED_IS_FAILED=1 ansible-playbook --syntax-check --inventory inventories/production $(ANSIBLE_PLAYBOOKS)
	cd ansible && ANSIBLE_INVENTORY_ANY_UNPARSED_IS_FAILED=1 ansible-playbook --syntax-check --inventory inventories/staging $(ANSIBLE_PLAYBOOKS)
	cd ansible && ansible-playbook --syntax-check --inventory inventories/sandbox $(ANSIBLE_PLAYBOOKS)
	cd ansible && ansible-lint -v -x ANSIBLE0010 --exclude=roles/vendor *.yml

$(MOLECULE_SUITE_TARGETS):
	cd ansible/roles/$(subst test-molecule-,,$@) && \
	molecule test --all

test: $(MOLECULE_SUITE_TARGETS)
test-molecule-only: $(MOLECULE_SUITE_TARGETS)

.PHONY: inventory lint setup test $(MOLECULE_SUITE_TARGETS)
