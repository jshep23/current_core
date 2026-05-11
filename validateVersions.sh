#!/bin/bash

pubspecVersion=$(./getVersion.sh)
# README might have 'current: ^1.0.0'. extract the version part.
readmeVersion=$(grep "current:" README.md | sed 's/.*current: \^//' | xargs)
changeLogHeader="$(head -n 1 CHANGELOG.md)"

expectedChangeLogHeader="## $pubspecVersion"

if [ "$expectedChangeLogHeader" != "$changeLogHeader" ]; then
    echo "Version Mismatch Found:"
    echo "  pubspec.yaml: $pubspecVersion"
    echo "  CHANGELOG.md: $changeLogHeader"
    echo "::error file=CHANGELOG.md::Change log should begin with $expectedChangeLogHeader"
    exit 1
fi

# If a README version is found, ensure it matches
if [ -n "$readmeVersion" ] && [ "$readmeVersion" != "$pubspecVersion" ]; then
    echo "Version Mismatch Found:"
    echo "  pubspec.yaml: $pubspecVersion"
    echo "  README.md:    $readmeVersion"
    echo "::error file=README.md::README version ($readmeVersion) does not match pubspec version ($pubspecVersion)"
    exit 1
fi

echo "Successfully validated version $pubspecVersion"
