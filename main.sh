#!/bin/bash
source config.sh
source colors.sh

die () {
    echo >&2 "$@";
    exit 1;
}

[ "$#" -eq 1 ] || die "1 argument required, $# provided"

[ -d "$factorioLocal" ] || die "Factorio local directory does not exist"
[ -d "$factorioRepo" ] || die "Factorio repo directory does not exist"
[ -d "$factorioBackup" ] || die "Factorio backup directory does not exist"

# validate the current argument was provided, either push or pull
if [ "$1" = "push" ] || [ "$1" = "pull" ]; then
    print_style "Valid argument provided\n" "success";
    # If the argument is push, then copy all files from LOCAL and push to github
    if [ "$1" = "push" ]; then
        print_style "Preparing directories...\n" "info";
        print_style "Coping from ${factorioLocal} to ${factorioBackup}...\n" "warning";
        cp -r "$factorioLocal"/* $factorioBackup
        print_style "Backed up local files\n" "success";
        print_style "Pushing to github...\n" "info";
        cp -r "$factorioLocal"/* $factorioRepo
        git add .
        git commit -m "Update"
        git push
        print_style "Push completed!\n" "success";
    # If the argument is pull, then copy all files from github and push to LOCAL
    elif [ "$1" = "pull" ]; then
        print_style "Pulling from github\n" "info";
        git pull
        print_style "Coping from ${factorioRepo} to ${factorioLocal}...\n" "warning";
        cp -r $factorioRepo/* "$factorioLocal"
        print_style "Updated local files!\n" "success";
    fi
fi
