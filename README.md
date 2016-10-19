# Euler Manager

[![Code Climate](https://codeclimate.com/github/yaworsw/euler-manager.png)](https://codeclimate.com/github/yaworsw/euler-manager) [![Code Climate](https://codeclimate.com/github/yaworsw/euler-manager/coverage.png)](https://codeclimate.com/github/yaworsw/euler-manager) [![Build Status](https://travis-ci.org/yaworsw/euler-manager.svg?branch=master)](https://travis-ci.org/yaworsw/euler-manager)

Manage [Project Euler](https://projecteuler.net/) problems form the command line.

## Installing

    $ gem install euler-manager

## Usage

Euler manager has 7 commands:

`init` initializes an empty `Eulerfile.rb` in the directory you are currently
in.

    $ euler init

`new` initializes a solution.  This typically means creating the directory for
the solution and populating it with some files.

    $ euler new [problem_id] [language]

`desc` shows a problem's prompt.

    $ euler desc [problem_id]

`run` executes a solution.

    $ euler run [problem_id] [language]

`test` runs a solution to see if it is correct.

    $ euler test [problem_id] [language]

`test_all` runs all of your solutions to see if they are correct.

    $ euler test_all

`include_images` will copy Project Euler's images into your euler managed
directory so that you can access them without an Internet connection.

    $ euler include_images

If you do not pass a problem id and language to the `desc`, `run`, or `test`
commands Euler manager will use the directory it was invoked from to try to
guess which problem id and language to use.  So if you want to run the ruby
solution for problem number 1 then you can just run `$ euelr run` from `1/ruby`
(by default) and Euler manager will run the ruby solution for problem 1.

## Supported Programming Languages

- Bash
- C
- coffeescript
- elixir
- haskell
- java
- javascript
- julia
- perl
- php
- python
- ruby
- scala

## Configuring Euler Manager

To configure the Euler manager place an `Eulerfile.rb` in the root of your
project.  Typically you can just keep this file empty but if you want to change
any of the Euler manager's defaults or register an additional language you would
do that here.

See `/example/Eulerfile.rb` for an example `Eulerfile.rb`.

### Registering Additional Languages

If Euler manager does not support your programming language of choice by default
or you would like to change how a supported language functions then you use the
`Euler.register_language` method.  This method accepts the name of the language
you are registering and a class definition for that language.

Feel free to send a pull request with additional languages.

#### Example

```ruby
Euler.register_language('ruby', Class.new do

  # Run the solution
  def run solution
    `ruby #{file_path(solution)}`
  end

  # Copy the template into the solution's directory
  def init solution
    FileUtils.cp(template_path, file_path(solution))
  end

  private

  # Returns the path to the solution
  def file_path solution
    "#{solution.dir}/#{solution.problem.id}.rb"
  end

  # Returns the path to the ruby template
  def template_path
    "#{File.dirname(__FILE__)}/templates/ruby.rb"
  end

end)
```

The `init` method of the language's class is optional but he `run` method is
required.

For more examples of registering languages see the `/lib/euler/languages`
directory or the `Eulerfile.rb` in the `/example` directory.

## Contributing

Pull requests are welcome!

Please send pull requests to the `develop` branch.

### To Do

- add more languages
- better error messages
- documentation could be better?
- tests could probably be better too
