coffeelint-still-todo
==============================

[CoffeeLint](http://www.coffeelint.org) rule that checks for TODO comments.

Installation
------------

```sh
npm install -g coffeelint-still-todo
```

Usage
-----

Add the following configuration to `coffeelint.json`:

```json
"still_todo": {
  "level": "warn",
  "module": "coffeelint-still-todo"
}
```

default level is `ignore`

Configuration
-------------

There are currently no configuration options

If you want this to be specific to a project then

```sh
npm install coffeelint-still-todo
```

and in the project `coffeelint.json`

```json
"still_todo": {
  "level": "warn",
  "module": "/path/to/project/node_modules/coffeelint-still-todo"
}
```
