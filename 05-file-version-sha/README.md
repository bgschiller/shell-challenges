I recently needed to come up with a version string for a collection of files. It would have been possible to manually keep track of a version, ticking it up whenever a file changed. But what can we do with shell? Here are the requirements:

1. The version string (which can be any reasonable-length string) should change whenever any of my source files changes. It doesn't need to "increase" though, just change.
2. The solution should be able to handle files being added or deleted.
3. Only Python files should affect the version string, not README or other non-code files. Oh, but there's also a shell script that we want to include.

I recommend using the `shasum` program, which should be already available on your machine (it might be called `sha1sum` or something like that).

Here's some steps for a possible pipeline:

1. list all .py files, plus `start.sh`
2. concatenate them together
3. `shasum`s output includes a listing of the name of the file. We only want the hash part, so strip out the filename somehow.

