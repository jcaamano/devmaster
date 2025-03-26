#!/bin/bash

/usr/local/go/bin/go install github.com/onsi/ginkgo/v2/ginkgo@latest
touch $HOME/.ack-ginkgo-rc
