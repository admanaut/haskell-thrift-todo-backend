# Motivation

When it comes to microservices communicating over HTTP, there is a lot of boilerplate we
need to write: define data transfer objects (DTOs), write their JSON instances, write server,
write client, and also maintain backwards compatibility when the contract is changing.
I'm looking for a solution that would allow me to describe services in a declarative way and
then generate the server and client code based on that spec. Whenever the spec changes,
new code is generated and distributed to users, therefore I only need to maintain
one thing: the spec file.

# haskell-thrift-todo-backend

In this repo I'm going to use Apache Thrift to spec the todo-backend service, and then
use the Haskell code generator Thrift provides to generate server and client libraries.
Finally write some tests.

## Apache Thrift

> Thrift is an interface definition language (IDL) and a binary communication protocol
> used for defining and creating services for numerous languages. It forms a remote procedure
> call (RPC) framework and was developed at Facebook for "scalable cross-language services development".
> It combines a software stack with a code generation engine to build cross-platform services
> which can connect applications written in a variety of languages and frameworks

### Install thrift

If you're using MacOS and brew, all you need to do is:

```
brew install thrift
```

otherwise follow the installation instructions at https://thrift.apache.org

### .thrift file

This file is the interface definition, made up of thrift types and Services, for
our todo-backend service.

see todo-backend.thrift

### thrift compiler

Once we have the thrift compiler installed and .thrift file defined we can use
the thrift compiler to generate the source code which will be used by the server
and client code we'll write.

To generate Haskell code:

```
thrift --gen hs todo-backend.thrift
```
