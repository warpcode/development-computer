SCENARIO_DIRS := $(shell for p in ./molecule/*; do  echo $$(basename "$$p"); done )

setup: setup-venv

setup-venv:
	[ ! -d "./.venv" ] && python3 -m venv .venv || true
	. .venv/bin/activate; python3 -m pip install -Ur requirements.txt

lint:
	. .venv/bin/activate; ansible-lint .

test: $(addprefix test-,$(SCENARIO_DIRS))

define test_template =
    .PHONY: test-$(1)

    test-$(1):
		. .venv/bin/activate; molecule test -s $(1)
endef
$(foreach cmpnt,$(SCENARIO_DIRS),$(eval $(call test_template,$(cmpnt))))
