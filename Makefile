## simple makefile to log workflow
.PHONY: all test clean build install
GOPATH := $(CURDIR)/_vendor:$(GOPATH)
GOFLAGS ?= $(GOFLAGS:)
TAG := $(TRAVIS_TAG)

all: get-deps build

get-deps:
	@go get -d

build:
	@go build $(GOFLAGS) ./...

package:
	zip slackcat.zip slackcat

install:
	@go get $(GOFLAGS) ./...

test: install
	@go test $(GOFLAGS) ./...

bench: install
	@go test -run=NONE -bench=. $(GOFLAGS) ./...

clean:
	@go clean $(GOFLAGS) -i ./...

## EOF
