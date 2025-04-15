#!/bin/bash
set -euo pipefail

source_dir=${1:?"missing argument: source directory"}

function copy_binaries_recursive() {
    destination_dir="$1"

    args=(
        -path '*'
        -and -not -path '*/_archive/*'
        -and -not -path '*/target/*'
        -and -not -path '*/.godot/*'
        -and -not -path '*/src/*'
        \(
        -path ''
        -or -path '*/bin/*'
        \)
    )

    find "$source_dir" "${args[@]}" -print0 | while IFS= read -r -d '' file; do
    	destination="$destination_dir/$(basename "$file" .sh)"
    	
    	cp "$file" "$destination" &>/dev/null || continue
    	chmod +x "$destination"
    	echo "copied '"$file"' to '"$destination"'"
    done
}

copy_binaries_recursive ~/.bin
copy_binaries_recursive ~/.local/bin

