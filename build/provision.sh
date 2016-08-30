#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
pushd "$DIR"> /dev/null

declare -A repos=(
    ["https://github.com/nverno/dart-mode"]="dart-mode"
    ["https://github.com/nverno/company-dart"]="company-dart"
    ["https://github.com/jacktasia/dumb-jump"]="dumb-jump"
    ["https://github.com/dart-lang/dart-samples"]="samples"
)

# get / update resource repos
get_repos () {
    for repo in "${!repos[@]}"; do
        if [[ ! -d "${repos["$repo"]}" ]]; then
            git clone --depth 1 "$repo" "${repos["$repo"]}"
        else
            pushd "${repos["$repo"]}">/dev/null
            git pull --depth 1
            popd>/dev/null
        fi
    done
}

get_page () {
    wget "https://www.dartlang.org/guides/language/language-tour"
    mv language-tour tour.html
}

[[ ! -f tour.html ]] && get_page
get_repos

popd >/dev/null
