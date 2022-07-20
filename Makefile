.PHONY: help setup serve

help:
	@echo "setup - create python3 virtual environment, install dependencies"
	@echo "serve - run the Certificate Authority"
setup:
	python3 -m venv .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install kivymd
	docker pull kivy/buildozer
	docker run --volume ${PWD}:/home/user/hostcwd kivy/buildozer --version
	docker run --volume ${PWD}:/home/user/hostcwd kivy/buildozer init
	# .venv/bin/buildozer init

acceptlicense:
	docker run -it -v ${PWD}:/home/user/hostcwd kivy/buildozer android debug

buildozer:
	docker run --volume ${PWD}:/home/user/hostcwd kivy/buildozer android debug deploy run
	# CC=g++ CXX=gcc .venv/bin/buildozer android debug deploy run

cleandozer:
	rm -rf ~/.buildozer
	rm -rf .buildozer

run:
	.venv/bin/python testapp/main.py
