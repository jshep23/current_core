#!/bin/bash

# Extract the current version strictly from the top-level 'version' key in pubspec.yaml
grep "^version: " pubspec.yaml | sed 's/^version: //' | xargs
