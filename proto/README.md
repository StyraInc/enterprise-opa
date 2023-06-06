# Styra Enterprise OPA gRPC API

This folder contains the definitions of [Protocol Buffers][protobuf] used by [Styra Load][gh-styra-load].

We use [Buf][buf] to manage and generate source code from the protocol buffer definitions.
The protobuf definitions here are a mirror of what we have pushed to the [`buf.build/styra/load`][buf-styra-load] repository in the Buf Registry.

   [protobuf]: https://developers.google.com/protocol-buffers/
   [buf]: https://github.com/bufbuild/buf
   [gh-styra-load]: https://github.com/StyraInc/load
   [buf-styra-load]: https://buf.build/styra/load

## Build

Running `buf generate` in this folder (or `./buf.gen.yaml` if you're on a Linux system) should create the necessary Golang files under a folder named `gen/`.

For supporting other languages, you will need to modify the `buf.gen.yaml` file to add the appropriate generation arguments for your language of choice.

## Linting

To lint the protobuf files, try running `buf lint` in this folder.

## License

The contents of this folder (Buf files and protobuf definitions) are released under the [Apache v2.0 license][apache-v2] license.

   [apache-v2]: https://www.apache.org/licenses/LICENSE-2.0.html
