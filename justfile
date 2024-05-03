[private]
@default:
    just --list

build:
    docker build . -t nginx-test

test-nginx: build
    docker run --rm -v '{{ justfile_directory() }}:/etc/nginx:ro' nginx-test nginx -t

test-gixy: build
    docker run --rm -v '{{ justfile_directory() }}:/etc/nginx:ro' nginx-test gixy

test: test-nginx test-gixy
