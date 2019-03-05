gen: todobackend.thrift
	thrift -r --gen hs --out lib/todo-backend/src/ todobackend.thrift
	thrift -r --gen hs --out lib/todo-backend-added/src/ todobackendadded.thrift
	thrift -r --gen hs --out lib/todo-backend-removed/src/ todobackendremoved.thrift

build:
	stack build

protocols:
	stack exec examples-protocols

versioning:
	stack exec examples-versioning
