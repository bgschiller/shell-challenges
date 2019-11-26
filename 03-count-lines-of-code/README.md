# Count Lines of Code

Clone down a repo of your choice. Write a command to list the names of every file, even in nested subdirectories, that represents a source file. I recommend `find`.

Separately, write a command (or pipeline of commands) to print out the number of lines that are non-blank and aren't comment lines (only concern yourself with line comments (eg, `//` or `#`) and not block comments (`/*` or `(*`). Block comments make this a fair bit harder. I recommend `wc` and `sed` or `awk` for this.

Finally, put the two pieces together! You can use `xargs cat` for this. `xargs` "transposes" the lines of input its given into arguments for a new command. So you should be able to do something like this:

```bash
LIST_ALL_SOURCE_FILES |
xargs cat |
COUNT_ALL_NON_COMMENT_NON_BLANK_LINES
```
