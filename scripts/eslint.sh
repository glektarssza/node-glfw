#!/usr/bin/env bash

SCRIPT_SOURCE=${BASH_SOURCE[0]}
while [ -L "$SCRIPT_SOURCE" ]; do
  SCRIPT_DIR=$( cd -P "$( dirname "$SCRIPT_SOURCE" )" >/dev/null 2>&1 && pwd )
  SCRIPT_SOURCE=$(readlink "$SCRIPT_SOURCE")
  [[ $SCRIPT_SOURCE != /* ]] && SCRIPT_SOURCE=$SCRIPT_DIR/$SCRIPT_SOURCE
done
SCRIPT_DIR=$( cd -P "$( dirname "$SCRIPT_SOURCE" )" >/dev/null 2>&1 && pwd )

#-- Setup paths
PROJECT_ROOT="$SCRIPT_DIR/.."

#-- Setup options
OPT=$1
ESLINT_FORMAT_OPTS=()
SOURCE_FILES=()
while [[ -n "$OPT" ]]; do
    case "$OPT" in
        --help|-h)
            echo "eslint.sh [OPTS] [FILE...]"
            echo "Run \`eslint\` on source files."
            echo ""
            echo "== Options =="
            echo " --help|-h: Show this help information and then exit."
            echo " --warnings-as-errors: Treat lint warnings as errors."
            echo " --error-on-no-files: Error on no input files being found."
            echo " --no-error-on-no-files: Do not error on no input files being found."
            echo ""
            echo "== Arguments =="
            echo " FILE: The file or files to lint. If not provided then all files are linted."
            exit 0
        ;;
        --warnings-as-errors)
            ESLINT_FORMAT_OPTS+="--max-warnings=0"
        ;;
        --error-on-no-files)
            ESLINT_FORMAT_OPTS=${ESLINT_FORMAT_OPTS[@]/--no-error-on-unmatched-pattern}
        ;;
        --no-error-on-no-files)
            ESLINT_FORMAT_OPTS+="--no-error-on-unmatched-pattern"
        ;;
        *)
            SOURCE_FILES+="$OPT"
        ;;
    esac
    shift 1
    OPT=$1
done

if [[ ${#SOURCE_FILES[@]} == 0 ]]; then
    IFS=" "
    SOURCE_FILES=( $(find -E "$PROJECT_ROOT/src/" -type f \( -iregex ".*(ts)\$" \) | xargs) )
    unset IFS
fi

if [[ ${#SOURCE_FILES[@]} == 0 ]]; then
    echo "No source files to lint, skipping..."
    exit 0
else
    echo "Linting ${#SOURCE_FILES[@]} files..."
fi

$PROJECT_ROOT/node_modules/.bin/eslint ${ESLINT_FORMAT_OPTS[@]} ${SOURCE_FILES[@]}

ERROR_CODE=$?

if [[ $ERROR_CODE != 0 ]]; then
    echo "Linting failed!"
    exit $ERROR_CODE
fi
