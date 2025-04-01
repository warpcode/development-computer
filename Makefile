setup: setup-venv

setup-venv:
	[ ! -d "./.venv" ] && python3 -m venv .venv || true
	. .venv/bin/activate; python3 -m pip install -Ur requirements.txt
