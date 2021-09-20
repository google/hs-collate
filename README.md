# collate

An Applicative Functor for extracting parts of a stream of values

[![Stack CI](https://github.com/google/hs-collate/actions/workflows/stack-ci.yml/badge.svg)](https://github.com/google/hs-collate/actions/workflows/stack-ci.yml)

## Disclaimer

This is not an officially supported Google product.

## Hackage Status

* [![collate](https://badgen.net/runkit/awpr/hackage/v/collate?icon=haskell&cache=600)](https://hackage.haskell.org/package/collate)
  ![Uploaded](https://badgen.net/runkit/awpr/hackage/t/collate?cache=600)
  ![Haddock](https://badgen.net/runkit/awpr/hackage/d/collate?cache=600)

## Overview

This provides a way to build up a computation that accesses many different
indices (possibly out-of-order) of a large stream of values, and run it in a
single scan over the stream.  In essence, this implements a hash-join.
