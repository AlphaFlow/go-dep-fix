# Build patched version of go dep
#

REPO=dep
REPO_URL=https://github.com/golang/dep.git
# REPO_URL=file:///${BUILD_DIR}/../golang.bak/${REPO}
BINARY=${REPO}
GO_PATH=$(shell go env GOPATH)
GO_ARCH=$(shell go env GOARCH)
GO_HOST=$(shell go env GOOS)

# version
VERSION=v0.5.1

# Symlink into GOPATH
GITHUB_USER=golang
BUILD_DIR=${GOPATH}/src/github.com/${GITHUB_USER}

# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS=-ldflags="-X main.version=${VERSION}-mod-patched"

# Build the project
all: ${GO_HOST}

build: ${GO_HOST}

darwin:
	rm -rf ${BUILD_DIR}/${REPO} ; \
	git clone ${REPO_URL} ${BUILD_DIR}/${REPO} ; \
	cp mod_patch.patch ${BUILD_DIR}/${REPO} ; \
	cd ${BUILD_DIR}/${REPO} ; \
	git am mod_patch.patch ; \
	GOOS=darwin GOARCH=${GO_ARCH} go build ${LDFLAGS} -o ${BINARY}-darwin-${GO_ARCH} ./cmd/dep ; \
	cd - >/dev/null

linux:
	rm -rf ${BUILD_DIR}/${REPO} ; \
	git clone ${REPO_URL} ${BUILD_DIR}/${REPO} ; \
	cp mod_patch.patch ${BUILD_DIR}/${REPO} ; \
	cd ${BUILD_DIR}/${REPO} ; \
	git am mod_patch.patch ; \
	GOOS=linux GOARCH=${GO_ARCH} go build ${LDFLAGS} -o ${BINARY}-linux-${GO_ARCH} ./cmd/dep ; \
	cd - >/dev/null

install: install-${GO_HOST}

install-darwin: darwin
	cd ${BUILD_DIR}/${REPO} ; \
	cp ${BINARY}-darwin-${GO_ARCH} /usr/local/bin ; \
	chown ${USER}:admin /usr/local/bin/${BINARY}-darwin-${GO_ARCH} ; \
	chmod 755 /usr/local/bin/${BINARY}-darwin-${GO_ARCH} ; \
	ln -sf /usr/local/bin/${BINARY}-darwin-${GO_ARCH} /usr/local/bin/${BINARY} ; \
	ln -sf /usr/local/bin/${BINARY}-linux-${GO_ARCH} ${GOPATH}/bin/${BINARY} ; \
	cd - >/dev/null

install-linux: linux
	cd ${BUILD_DIR}/${REPO} ; \
	cp ${BINARY}-linux-${GO_ARCH} /usr/local/bin ; \
	chown root:root /usr/local/bin/${BINARY}-linux-${GO_ARCH} ; \
	chmod 755 /usr/local/bin/${BINARY}-linux-${GO_ARCH} ; \
	ln -sf /usr/local/bin/${BINARY}-linux-${GO_ARCH} /usr/local/bin/${BINARY} ; \
	ln -sf /usr/local/bin/${BINARY}-linux-${GO_ARCH} ${GOPATH}/bin/${BINARY} ; \
	cd - >/dev/null

clean:
	-rm -f ${BINARY}-*

.PHONY: linux darwin install install-darwin install-linux clean
