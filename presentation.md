build-lists: true

# [fit] Intermediate Shell

---

## Prerequisites

You should already know (but in case you don't)


| *Command* | *Description*              |
|-----------|----------------------------|
| `cd`      | change directory           |
| `ls`      | list files and directories |
| `pwd`     | display full path of current directory |
| `mkdir`   | create a directory         |
| `rm`      | remove a directory         |
| `cp`      | copy a file or directory   |
| `mv`      | move or rename a file or directory |
| `echo`    | print text to STDOUT       |
| `cat`     | print contents of a file (or multiple) |
| `less`    | page through a file or STDIN |
| `head`    | display the first few lines of a file |
| `tail`    | display the last few lines of a file |
| `ctrl-C`  | cancel an in-progress command |

---

### Preparation:

```
brew install fortune cowsay lolcat jq
```
---

### [fit] The Spirit of the command line

---

![](./images/sorcerer-mickey-final-dribbble_2x.png)
![](./images/the-dragon-prince-season-1-26258-1200.jpg)

---

> “ugh, I could write a program to do this for me!”

---

### Moving around efficiently

- ctrl-a, ctrl-e, ctrl-w, ctrl-u, option-arrow
- ctrl-x,e to open in $EDITOR
- up-arrow
- ctrl-r, `history | grep`
- tab completion
- drag files to terminal

---
[.autoscale: true]
### Does the walker choose the $PATH, or the $PATH the walker?

- Make a file called `hello` that has

```bash
#!/usr/bin/env sh
say hello there
```

- from this directory, run `hello` (no `./`). Probably you get an error message.
- inspect your PATH by running `echo $PATH | tr : '\n'`
- add `.` (the current directory) to your PATH: `export PATH=$PATH:.`. Now run `hello` again.
- rename the file to `ls`. What happens when you run `ls` now?

---

### combining functionality: Pipes

1. Explore individually `fortune`, `cowsay`, `lolcat`. Use `<cmd> --help` or `man <cmd>` if you get stuck. I recommend trying to pipe things into these commands with echo (eg, `echo hello | lolcat`)
2. Write down a brief english description of what each command does. How does it transform its input? Compare notes with a neighbor.

---

# [fit] hacking time
![autoplay loop](./images/hack-time.mp4)

---

# [fit] github.com/bgschiller/shell-challenges