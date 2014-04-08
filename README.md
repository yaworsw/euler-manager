# Euler Manager

Manage [Project Euler](https://projecteuler.net/) problems form the command line.

## Usage

Euler manager has 4 commands:

    $ euler new [problem_id] [language]

`new` initializes a solution.

    $ euler desc [problem_id]

`desc` shows a problem's prompt.

    $ euler run [problem_id] [language]

`run` executes a solution.

    $ euler test [problem_id] [language]

`test` runs a solution to see if it is correct.

If you do not pass a problem id and language to the `desc`, `run`, or `test`
commands Euler manager will use the directory it was invoked from to try to
guess which problem id and language to use.  So if you want to run the ruby
solution for problem number 1 then you can just run `$ euelr run` from `1/ruby`
(by default) and Euler manager will run the ruby solution for problem 1.

## Configuring Euler Manager

TODO

### Registering Additional Languages

TODO
