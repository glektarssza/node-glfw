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
CLANG_FORMAT_OPTS=("--dry-run")
SOURCE_FILES=()
while [[ -n "$OPT" ]]; do
    case "$OPT" in
        --help|-h)
            echo "clang-format.sh [OPTS] [FILE...]"
            echo "Run \`clang-format\` on source files."
            echo ""
            echo "== Options =="
            echo " --help|-h: Show this help information and then exit."
            echo " --warnings-as-errors: Treat lint warnings as errors."
            echo " --fix: Fix any fixable issues."
            echo ""
            echo "== Arguments =="
            echo " FILE: The file or files to lint. If not provided then all files are linted."
            exit 0
        ;;
        --fix)
            CLANG_FORMAT_OPTS=${CLANG_FORMAT_OPTS[@]/--dry-run}
            CLANG_FORMAT_OPTS+="-i"
        ;;
        --warnings-as-errors)
            CLANG_FORMAT_OPTS+="-Werror"
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
    SOURCE_FILES=( $(find -E "$PROJECT_ROOT/src/" -type f \( -iregex ".*(cpp|cxx|cc|c|hpp|hxx|h)\$" \) | xargs) )
    unset IFS
fi

if [[ ${#SOURCE_FILES[@]} == 0 ]]; then
    echo "No source files to lint, skipping..."
    exit 0
else
    echo "Linting ${#SOURCE_FILES[@]} files..."
fi

clang-format --style=file:$PROJECT_ROOT/.clang-format ${CLANG_FORMAT_OPTS[@]} ${SOURCE_FILES[@]}

ERROR_CODE=$?

if [[ $ERROR_CODE != 0 ]]; then
    echo "Linting failed!"
    exit $ERROR_CODE
fi
