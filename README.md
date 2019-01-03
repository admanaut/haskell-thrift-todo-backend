# Motivation

When it comes to microservices over HTTP, there is a lot of boilerplate we need to write:
define data transfer objects (DTOs), write server, write client, and also maintain
backwards compatibility when the contract is changing. I'm looking for a solution that
would allow me to describe services in a declarative way and then generate the server
and client code based on that spec. Whenever the spec changes, new code is generated and
distributed to users, therefore I only need to maintain one thing: the spec file.

# haskell-thrift-todo-backend

In this repo I'm going to use Apache Thrift to spec the todo-backend service, and then
use the Haskell code generator Thrift provides to generate server and client libraries.
Finally write some tests.
