# Motivation

When it comes to microservices communication, there is a lot of boilerplate we need to write:
define data transfer objects (DTOs), write their JSON instances, write server, write client
library, and also maintain backwards compatibility when the contract changes.
I'm looking for a solution that would allow me to describe services in a declarative way and
then generate the server and client code based on that spec. Whenever the spec changes,
new code is generated and distributed to users, therefore I only need to maintain
one thing: the spec file.

# haskell-thrift-todo-backend

In this repo I'm going to use Apache Thrift to spec the todo-backend service, and then
use the Haskell code generator Thrift provides to generate server and client libraries.

## Apache Thrift

> Thrift is a _RPC framework_ that offers: an interface definition language (IDL) to describe
> services with; multiple transport options (sockets, pipes, HTTP, etc); and protocols
> (binary, JSON, compressed, and more). http://thrift.apache.org/static/files/thrift-20070401.pdf

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

### thrift code generator

Once we have the thrift code generator installed and .thrift file defined we can use
the thrift compiler to generate the source code which will be used by the server
and client code we'll write.

To generate Haskell code:

```
thrift -r --gen hs --out lib/todo-backend/src/ todobackend.thrift
```

## Examples

### binary protocol and socket transport

see https://github.com/admanaut/haskell-thrift-todo-backend/tree/master/src/Binary

### JSON protocol and socket transport

see https://github.com/admanaut/haskell-thrift-todo-backend/tree/master/src/JSON

### JSON protocol and HTTP transport

Unfortunately there's no implementation for HTTP transport in Haskell.

### execute examples

use stack to compile and execute the code

```
stack build
```

```
stack exec haskell-thrift-todo-backend
```

# Schema progression

Naturally, schemas evolve over time, to conform with new requirements, record fields
get added or removed, or containers change items type. So, a key feature of our IDL
is to have great support for schema versioning.

Let's take a look at how Thrift handles versioning

## Thrift Versioning

Versioning in Thrift is done via field identifiers. Every member of a struct is encoded
with a unique field identifier, the combination of this identifier and the type of the
field uniquely identifies the field.

```
struct Todo {
 1: required Title title,
 2: required Id id,
 3: required Completed completed,
 4: required Order order
}
```

^ example of field identifiers

Function arguments also use identifiers. This allows for version-safe changes of method params.

```Todo createTodo( 1:Title title )```

^ example of function arguments identifiers

## Version mismach

There are four cases in which version mismatches may occur:

1. _Added field, old client, new server_
   - old client does not send the new field. new server uses defaults for missing field.

2. _Removed field, old client, new server_
   - old client sends the removed field. new server ignores it.

3. _Added field, new client, old server_
   - new client sends the new field. old server does not recognise it and ignores it.

4. _Removed field, new client, old server_
   - new client doesn't send the field. old server most probably will crash
   because it doesn't have any defaults for the missing field.
   it is recommended to deploy the new server first in this situation.

In order to demonstrate the above scenarios, I created 2 new _.thrift_ files
`todobackendadded.thrift` and `todobackendremoved.thrift`, where I added a new record
field _related_, and removed the _order_ field respectively.

I have also created two new libraries, `todo-backend-added` and `todo-backend-removed`, so we can
have all versions of the todo-backend at the same time.

## Haskell library and optional fields

A record field in Thrift can be decorated with:

* _required_ - must exist on read, must be set on write
* _optional_ - may or may not be set
* explicit default value - this is not a decorator in itself but you can specify a default value using the (=) sign

if neither is specified, an implicit default value is used.

The Haskell library generates code for optional and default values like this:

1) no decorator specified

```
struct Todo {
 ...
 5: Related related
 ...
}
```

in this case an implicit default value is used,
like _0_ for int32, _[]_ for lists and _""_ for strings

2) optional decorator and no explicit default value

```
struct Todo {
 ...
 5: optional Related related
 ...
}
```

in this case a Maybe is used with an implicit default value,
like _Just 0_ for int32, _Just []_ for lists and _Just ""_ for strings

3) optional decorator with explicit default value

```
struct Todo {
 ...
 5: optional Related related=[10]
 ...
}
```

in this case a Maybe is used with the explicit default value,
like _Just 10_ for int32, _Just [10]_ for lists and _Just "10"_ for strings

4) no decorator but explicit default value

```
struct Todo {
 ...
 5: Related related=[10]
 ...
}
```

this case is interesting, the explicit default value is used,
like _10_ for int32, _[10]_ for lists and _"10"_ for strings
