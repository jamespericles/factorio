#!/bin/bash
source config.sh

die () {
    echo >&2 "$@";
    exit 1;
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

[ -d "$factorioLocal" ] || die "Factorio local directory does not exist"
[ -d "$factorioRepo" ] || die "Factorio repo directory does not exist"
[ -d "$factorioBackup" ] || die "Factorio backup directory does not exist"

# validate the current argument was provided, either push or pull
if [ "$1" = "push" ] || [ "$1" = "pull" ] || [ "$1" = "update" ]; then
    echo "Valid argument provided"
    # If the argument is push, then copy all files from LOCAL and push to github
    if [ "$1" = "push" ]; then
        echo "Preparing directories..."
        echo "Coping from ${factorioLocal} to ${factorioBackup}..."
        cp -r "$factorioLocal"/* $factorioBackup
        echo "Backed up local files"
        echo "Pushing to github..."
        cp -r "$factorioLocal"/* $factorioRepo
        git add .
        git commit -m "Update"
        git push
        echo "Push completed"
    # If the argument is pull, then copy all files from github and push to LOCAL
    elif [ "$1" = "pull" ]; then
        echo "Pulling from github"
        git pull
        echo "Coping from ${factorioRepo} to ${factorioLocal}..."
        cp -r $factorioRepo/* "$factorioLocal"
        echo "Updated local files"
    fi
fi
