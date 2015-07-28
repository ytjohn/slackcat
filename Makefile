## simple makefile to log workflow
.PHONY: all test clean build install
GOPATH := $(CURDIR)/_vendor:$(GOPATH)
GOFLAGS ?= $(GOFLAGS:)
TAG := $(TRAVIS_TAG)

all: get-deps build

get-deps:
	@go get -d

build:
	@go build $(GOFLAGS) slackcat.go

package:
	zip slackcat-$(TRAVIS_TAG).zip slackcat
	fpm -s dir -t deb --url http://github.com/ytjohn/slackcat --vendor ytjohn --license MIT \
	  --maintainer 'John Hogenmiller <john@yourtech.us>' --description="Post messages to Slack from the command line" \
	  -n slackcat -v "$TRAVIS_TAG" --prefix /usr/local/bin slackcat
	fpm -s dir -t rpm --url http://github.com/ytjohn/slackcat --vendor ytjohn --license MIT \
	  --maintainer 'John Hogenmiller <john@yourtech.us>' --description="Post messages to Slack from the command line" \
	  -n slackcat -v "$TRAVIS_TAG" --prefix /usr/local/bin slackcat
install:
	@go get $(GOFLAGS) ./...

test: install
	@go test $(GOFLAGS) ./...

bench: install
	@go test -run=NONE -bench=. $(GOFLAGS) ./...

clean:
	@go clean $(GOFLAGS) -i ./...

## EOF
