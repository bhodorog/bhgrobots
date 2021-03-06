## Environment
ruby 2.2.0
rvm 1.26.10

## Install

`rake install`


## Run

`bhgrobots FILENAME`
FILENAME can be any valid instruction FILE (no proper validation yet inplace)

## Tests

`rake test`

`rake test[test_file1,test_file2]`, where _test\_file*_ can be any valid unit test file from _test/cases/test*_

options to test/unit can be passed with `rake opts="......." test`

## Assumptions
The following assumption regarding any future requirements have driven
the design of this app:

1. New commands will be added in the future
1. Existing commands will change
1. The limits of the table will change
1. Multiple robots will be added

## Benefits

1. Commands instances are being constructed using reflection
1. Commands which receive some args have these kept in an instance var
   @extra. This way would be easier in the future to enhance existing
   commands (e.g. MOVE can receive the distance to move with as an
   argument). Each class will have to parse and use the info in @extra
   as desired.
1. Commands objects are loosely coupled with the Table object. Table
   just accepts generic commands and calls their .execute method. It
   also passes self as an argument so that each command can do their
   magic.

## TODOS

1. (optional) Have some magic methods generated for Table class based command name to have the api nicer. Instead of tbl.accept(Command.new(args)) will be tabl.command(args)
1. (optional) Have the cmds streamed instead of bulk processed to enable processing of  huge commands file
1. Have proper validation in place for reading an Instruction File
1. Have the instruction files distributed as res files and have the user choose by cmd line which to execute.
1. (optional) Add the project to travis
1. (optional) Proper rdoc,ri would be nice
