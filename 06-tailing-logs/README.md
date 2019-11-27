In some web environments, you'll have several log files. It can be handy to see all of them at once, but it's annoying to open five terminals to watch them all come in.

Run `mk-logs.sh`, which writes logs to several files in `./logs/`. Now run `tail -f logs/error.log` to watch one of the files as it is updated.

Write a command that displays lines from all the log files as they come in.

The access log is noisy! We probably don't care for that level of detail. Filter it out from the stream.