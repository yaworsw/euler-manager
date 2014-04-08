# Euler Manager Example

## Eulerfile

The root of your project Euler solutions needs to have an `Eulerfile.rb`.

In this file you can configure the locations of Euler manager's data, the
strategies it uses to manage and parse directories and register languages.

Euler manager uses some pretty sensible defaults and comes with a number of
languages already configured.  Its likely you will be able to get by with having
your `Eulerfile.rb` be blank.

## Directory Structure

By default Euler manager creates solution directories with the top directory
being the ID of the problem and the child directory being the language of the
solution.

Also by default Euler manger creates a `README.md` file in the problem directory
with the problem's name and description.

### /lib

Its recommended to have a `lib` directory where you can store common functions
in the languages you're solving problems in.
