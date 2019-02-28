gen: todobackend.thrift
	thrift -r --gen hs --out lib/todo-backend/src/ todobackend.thrift

build:
	stack build

protocols:
	stack exec examples-protocols
