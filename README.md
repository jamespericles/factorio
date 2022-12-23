# Factorio Save Management

I don't typically play games on my computer, and so I don't have much of an interest in creating and using a Steam account which I recognize would make what the repo accomplishes redundant but I digress.

I recently purchased (and fell in love with) Factorio for the Switch and have since purchased a copy for my computer. To make switching from my desktop to my laptop easier, I wrote `main.sh`.

### Getting Started

#### Handle Env Variables and Pathways

Create a `config.sh` with the following variables:

```bash
#!/bin/env bash
factorioLocal=route/to/local/files
factorioRepo=route/to/this/repo
factorioBackup=route/to/backup/folder
```

This config file isn't necessary if you export the above variables from your `.bash_profile`, which I've done. I created this config file for my laptop, which I don't work off of and therefore haven't created a `.bash_profile` for. If you'd like to omit this process, remove line 2 from `main.sh`

For Mac users, your local Factorio files can be found in: `/Users/userName/Library/Application Support/factorio` (note: be sure to wrap the path in double quotes to avoid globbing and word splitting.

#### Using the Script

The script itself is incredibly simple. First we pull in those variables initiated in the `config.sh` file I mentioned. There's a simple `die` command to exit if a command was not given to the script.

```bash
sh main.sh push
```

All the files from `$factorioLocal` are copied to `$factorioBackup` first, then to `$factorioRepo`, afterwhich everything is pushed to the repo.

```bash
sh main.sh pull
```

Everything will be pulled from the repo, then copied to `$factorioLocal`.
