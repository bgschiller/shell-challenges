Run `curl 'https://api.github.com/repos/Denver-Devs/denverdevs.org/commits?per_page=100'`.

Ugh! What am I supposed to do with all that output? It scrolled past faster than I could read it. Let's try again. Run `curl 'https://api.github.com/repos/Denver-Devs/denverdevs.org/commits?per_page=100' | jq '.[0]'`, which says "take the output from curl and extract the element at key '0' (the first entry in the array).

That's at least shorter. But all I really care about right now is the committer name. Before we refine our query though, let's make a structural change. It makes no sense to keep asking github for this json file over and over again. Let's save it and re-use it. Run `curl 'https://api.github.com/repos/Denver-Devs/denverdevs.org/commits?per_page=100' > commits.json`. This says "Take the stdout from curl and write it to the commits.json file".

Now, instead of running `curl` every time we tweak our `jq` script, we can redirect that file to stdin instead: `< commits.json jq '.[0]'`. Faster _and_ nicer to the github api.

Run `< commits.json jq '.commit.committer.name'`. You should get a big long list of names. Sort and deduplicate them, and then present them in descending order of frequency. When I'm running this on Nov 26, 2019, I get the following:

```
  50 "GitHub"
  47 "Dan Hannigan"
   2 "Derik Linch"
   1 "Brian Schiller"
```

One thing that's funny about jq is that is uses pipe characters (`|`) in its query language. But, as we've seen, the pipe is an important character to the shell itself. We will usually need to quote our `jq` query in single quotes, so that the shell can tell which pipes are for it and which ones are for `jq`.

There sure are a lot of commits attributed to "GitHub". That seems funny. Use `jq`'s `select()` function to limit commits to _only_ those where the `.commit.committer.name` is "GitHub", and see what's going on with them (You may need to refer to the [jq manual](https://stedolan.github.io/jq/manual/). Is there some other key we should be using instead of `.commit.committer.name`? Once I'd sorted out this problem, I got the following:

```
  69 "Dan Hannigan"
  10 "Gabi Procell"
   7 "dependabot[bot]"
   3 "James Gibson"
   2 "Jason Rist"
   2 "Derik Linch"
   1 "amng9560"
   1 "Ted Summer"
   1 "Matt Lewis"
   1 "Kevin McKernan"
   1 "Hamp Goodwin"
   1 "Chuck Harmston"
   1 "Brian Schiller"
```

Much better! Something jumped out at me when I was reviewing this data: some of the commits are signed! What kind of crypto nerds are out here signing their commits to denverdevs.org? To find out, we'll need to filter the data down to only verified commits.

Since this is still exploratory analysis, I kind of want to see all the data again. But not like a caveman! I want it nicely paged, scrollable, and searchable with `less`. If you do `jq ... | less` then `jq` will notice that you're piping its output into a program, not actually displaying it, and so it will strip all the color from its output. (The ascii escape codes used to color text in the terminal can mess up programs that don't expect them). But we still want the color, so pass the `--color-output` flag to jq and we'll be able to use `less` and still keep color.

> Protip: I have `jl` aliased to `jq '.' --color-output | less` in my terminal. That lets me do `pbpaste | jl` and see colorized, paginated json right away.

Once you come up with a hypothesis for what the verified commits have in common, write another `jq` command to see if you're correct.
