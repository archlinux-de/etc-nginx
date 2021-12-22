.PHONY: build test-nginx test-gixy test

build:
	docker build . -t nginx-test

test-nginx: build
	docker run --rm --userns host -v $$(pwd):/etc/nginx:ro nginx-test nginx -t

test-gixy: build
	docker run --rm --userns host -v $$(pwd):/etc/nginx:ro nginx-test gixy

test: test-nginx test-gixy
