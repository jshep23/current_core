#!/bin/bash

# Returns exit code 0 if the version in pubspec.yaml has changed compared to HEAD~1.
# Returns exit code 1 otherwise.

get_version_from_content() {
  echo "$1" | grep "^version: " | sed 's/^version: //' | xargs
}

current_version=$(./getVersion.sh)

# Get the version from the previous commit
previous_content=$(git show HEAD~1:pubspec.yaml 2>/dev/null)
if [ $? -eq 0 ]; then
    previous_version=$(get_version_from_content "$previous_content")
else
    previous_version=""
fi

if [ -n "$current_version" ] && [ "$current_version" != "$previous_version" ]; then
    exit 0
else
    exit 1
fi
