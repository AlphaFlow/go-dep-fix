# go dep fix

This repo contains a (temporary) fix to resolve the issue referenced in [PR#2151](https://github.com/golang/dep/issues/2151)
where `dep ensure` will fail when encountering a proxy that returns a __mod__ VCS tag as documented here:

[Remote import paths](https://golang.org/cmd/go/#hdr-Remote_import_paths)

## Usage

The Makefile will determine your platform and architecture from existing Golang configuration values. Therefore, all you
need to do is:

```bash
prompt> cd $GOPATH
prompt> mkdir -p src/github.com/alphaflow
prompt> cd src/github.com/alphaflow
prompt> git clone https://github.com/AlphaFlow/go-dep-fix.git
prompt> cd git-dep-fix
prompt> make && make install
```

Then use `dep ensure` as usual.

---
AlphaFlow Inc.
