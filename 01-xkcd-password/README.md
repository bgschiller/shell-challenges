# xkcd Password Generator

Prompted by the xkcd comic strip, you decide to make a shell pipeline to suggest passwords consisting of 4 random common words.

<a href="https://xkcd.com/936/">
  <img title="To anyone who understands information theory and security and is in an infuriating argument with someone who does not (possibly involving mixed case), I sincerely apologize." src="https://imgs.xkcd.com/comics/password_strength.png">
</a>

## Get the words

First things first, let's download some words. You already know about `/usr/share/dict/words`, but some of those are really obscure. You want a _curated_ list.

Do some googling to find a list that appeals to you, or use the one at `https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-usa-no-swears.txt`.

You should be able to download it with

```
curl https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-usa-no-swears.txt > words
```

curl is a program for making HTTP requests. When called with just a URL and no other arguments, it makes a GET request and outputs the response body to stdout. we're also using shell redirection `> words` to say "the stdout of this curl command should be sent to a file called 'words'".

## Trim down the list

One of the first things we'll want to do is throw away words that are too long or too short. We don't want to make our passwords too difficult to remember, or too easy to guess! You can change this up as you want, but I'm going to use 5-8 letter words as the sweet spot.

How can we filter down the list? We want to keep only lines that have 5, 6, 7, or 8 characters in them. We can use `grep` to keep only lines that match a pattern. Here's the pattern we'll look for:

1. The beginning of the line `^`
2. A single letter `[A-Za-z]`
3. A single letter `[A-Za-z]`
4. A single letter `[A-Za-z]`
5. A single letter `[A-Za-z]`
6. A single letter `[A-Za-z]`
8. Either a single letter, or nothing `[A-Za-z]?`
9. Either a single letter, or nothing `[A-Za-z]?`
10. Either a single letter, or nothing `[A-Za-z]?`
11. The end of the line `$`

Why do we need to specifically call out the beginning and end of the line? `grep` will include a line if a match is found _anywhere_ in the line. If we didn't require the beginning and end of the line to be on either side of our pattern, we could end up with a 100-letter word, because `grep` noticed that the long word's first eight letters matched our pattern.

The `[A-Za-z]` is a character class that includes every uppercase and lowercase letter. The question mark modifies it, adding on "or nothing is okay too". Here's that regex all on one line the way we would actually write it:

```
^[A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z][A-Za-z]?[A-Za-z]?[A-Za-z]?$
```

This doesn't look very... efficient. In fact, there are a couple of shorthands we can use to avoid typing so much. First, there's a regex syntax for repeating a pattern: you tack `{min,max}` onto the end. So our regex will now look like:

```
^[A-Za-z]{5,8}$
```

Much better! If we're okay with a small change in exactly what the pattern means, we can do even better. There are some character classes used so often that there are built-in shorthands for them. One of those is `[A-Za-z0-9_]`: upper- and lowercase letters, digits, and underscores. The shorthand is `\w` If we're okay with allowing digits and underscores in our words, we can write our regex as:

```
^\w{5,8}$
```

Nice! That's starting to look cryptic, as a proper regex should. Let's use it.

The syntax for `grep` is `grep PATTERN FILE`. We'll also have to use the `-E` flag for "extended regex". So we can run

```bash
grep -E "^\w{5,8}$" words
```

This should print a great many words, but if all goes well only ones with between 5 and 8 letters. Be sure to use quotes around the regex pattern. Otherwise your shell will eat the backslash and treat the `{5,8}` bit a bit strangely too. We'll cover that in a later lesson.

If you want to not overflow your shell, you can use the `head` command as part of a pipeline:

```bash
grep -E "^\w{5,8}$" words | head
```

A pipeline is a fun construct in shell scripting that lets us string together many transformations to some data without writing to a file between each one. This one says "make the output of `grep` the input of `head`". So, whatever `grep` produces (a list of words of the proper length) is what `head` will be given to act on. `head`'s function is to print the first 10 lines of a file and no more.

## Put it in a random order

We will use the `sort` program to randomize the order of our list. By default, `sort` will sort its input. We're going to use the `--random-sort` flag to tell it to sort randomly instead.

Remember that pipeline trick, with `head`? We'll use the same sort of thing again. We want to use the output of `grep` as the input to `sort`.

```bash
grep -E "^\w{5,8}$" words | sort --random-sort
```

### Alternative: `shuf`

If you have GNU coreutils installed, you can use `shuf` which uses a more efficient algorithm for shuffling than `sort --random-sort`. We'll also explore a more "from scratch" way of doing this in a later challenge, when we pretend we don't know about `shuf` or `sort --random-sort`.

## Only take a few

We've seen already how to limit the output of our pipeline using `head`. As it happens, `head` also accepts a parameter for the number of lines: `-n`. Use this flag to only keep the first four lines of the randomly sorted words.

## Put them all on one line

As it is now, the words are all on separate lines. Let's put them all on one line with the `tr` command, short for "translate". We'll translate all newline characters `"\n"` to spaces `" "`.

## All together now

```bash
grep -E "^\w{5,8}$" words | # Only 5-8 letter words
sort --random-sort | # in a random order
head -n 4 | # just the first 4
tr "\n" " " # replace newlines with spaces
```

> tourism jelsoft digest riders