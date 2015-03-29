## Environment
ruby 2.2.0

## Tests
run with `ruby -I'./' tests.py`


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

## Ideas

1. Have some magic methods generated for Table class based command name to have the api nicer. Instead of tbl.accept(Command.new(args)) will be tabl.command(args)
