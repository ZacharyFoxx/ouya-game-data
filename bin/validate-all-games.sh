#!/bin/sh
# Validate all ouya game data files
# in all the folders listed in the folders file
set -e
for gamefile in `git diff --name-only HEAD~1 | grep -E "^(\`paste -d '|' -s folders\`)"`; do
    iparams="$iparams -i $gamefile"
    echo "$gamefile"
    validate-json "$gamefile" ouya-game.schema.json
done

for folder in `cat folders`; do
    iparams=""
    for gamefile in $folder/*.json; do
        iparams="$iparams -i $gamefile"
        echo "$gamefile"
        validate-json "$gamefile" ouya-game.schema.json
    done
    jsonschema $iparams ouya-game.schema.json
done
