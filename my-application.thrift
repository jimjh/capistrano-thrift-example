#!/usr/local/bin/thrift --gen rb --out gen

# My Application Service
# This file defines the RPC interface. Use `./my-application.thrift` to
# compile it and generate the ruby files
# Jim Lim <codex.is.poetry@gmail.com>

namespace rb MyApplication

service RPC {
  string ping()
}
