#!/bin/bash

die () {
    echo >&2 "$@";
    exit 1;
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

# validate the current argument was provided, either push pull or update
if [ "$1" = "push" ] || [ "$1" = "pull" ] || [ "$1" = "update" ]; then
    echo "Valid argument provided"
    # If the argument is push, then copy all files from LOCAL and push to github
    if [ "$1" = "push" ]; then
        echo "Pushing to github"
        cp -r "$factorioLocal"/* $factorioRepo
        git add .
        git commit -m "Update"
        git push
    # If the argument is pull, then copy all files from github and push to LOCAL
    elif [ "$1" = "pull" ]; then
        echo "Pulling from github"
        git pull
        cp -r $factorioRepo/* "$factorioLocal"
        echo "Updated local files"
    fi
fi
