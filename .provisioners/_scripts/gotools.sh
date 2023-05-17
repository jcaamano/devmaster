#!/bin/bash

/usr/local/go/bin/go install -mod=mod github.com/onsi/ginkgo/ginkgo
touch $HOME/.ack-ginkgo-rc
