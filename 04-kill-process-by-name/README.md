Kill process by name

First, run the `die-hard.sh` script found in this directory.

Sometimes a process will rudely refuse to listen to a Ctrl-C. Or maybe it's a background process, and there's nowhere to send it a ctrl-c.

In those cases, you can use the `kill` program to send it a SIGKILL signal that will stop it right away. But first you need to know its PID (process ID).

Run `ps ax` to get a list of all running processes on your computer. Pipe that into grep to find the offending process. This should be a much shorter list of processes (one or two probably).

At this point, you _could_ copy-paste the PID of the offending process and run `kill <PID>` on it. But this is shell class! Let's do it with shell commands.

We need to isolate just the PID column. Use the `cut` program to grab just the first column of your output. You'll likely need to specify the `-f` (field) and `-d` (delimiter) flags.

Finally, pipe the whole thing into `xargs kill`. You may need to experiment with flags passed into `kill` to ensure that you're sending a SIGKILL and not a SIGTERM (the default).
