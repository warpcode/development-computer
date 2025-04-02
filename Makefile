ROLES_DIRS := $(shell for p in ./roles/*; do  echo $$(basename "$$p"); done )

setup: setup-venv

setup-venv:
	[ ! -d "./.venv" ] && python3 -m venv .venv || true
	. .venv/bin/activate; python3 -m pip install -Ur requirements.txt

lint:
	. .venv/bin/activate; ansible-lint .

test: $(addprefix test-,$(ROLES_DIRS))

define test_template =
    .PHONY: test-$(1)

    test-$(1):
		. .venv/bin/activate; cd "roles/$(1)"; molecule test
endef
$(foreach cmpnt,$(ROLES_DIRS),$(eval $(call test_template,$(cmpnt))))
