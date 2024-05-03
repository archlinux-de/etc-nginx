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

fmt:
    #!/usr/bin/env fish
    just --unstable --fmt
    for f in '{{ justfile_directory() }}'/{conf.d,hosts.d,vhosts.d,nginx.conf}
        printf "%s: " (path basename $f)
        nginx-config-formatter -p "$f"
    end
