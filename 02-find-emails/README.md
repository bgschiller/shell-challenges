Find lines of an html file that contain an email. I recommend using an imperfect regex to match for emails. There aren't any in there trying to trip you up—the simple regex will probably work.

Read the `grep` man page to find how to make it print only the matching portion of a line (just the email with none of the surrounding text).

Write a `find` command to list all `.html` files (imagine there are more than three, so this step would actually be worth your time 😅).

Consider using `find ... | xargs grep ...`, which says "Take each line of output from the `find` command and add it as an additional argument to `grep ...`".

Present the final list of emails in sorted order, all lowercase, and with duplicates removed.