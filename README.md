# go dep fix

This repo contains a (temporary) fix to resolve the issue referenced in [PR#2151](https://github.com/golang/dep/issues/2151)
where `dep ensure` will fail when encountering a proxy that returns a __mod__ VCS tag as documented here:

[Remote import paths](https://golang.org/cmd/go/#hdr-Remote_import_paths)

## Usage

The Makefile will determine your platform and architecture from existing Golang configuration values. Therefore, all you
need to do is:

- clone the repo
- run make && make install

Then use `dep ensure` as usual.

---
AlphaFlow Inc.
