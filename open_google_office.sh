#!/bin/bash
file="$1"
extension="${file##*.}"  # Get file extension

if [[ "$extension" == "docx" ]]; then
    url="https://docs.google.com/document/u/0/import?importFormat=docx&uploadUrl=file://$file"
elif [[ "$extension" == "pptx" ]]; then
    url="https://docs.google.com/presentation/u/0/import?importFormat=pptx&uploadUrl=file://$file"
else
    echo "Unsupported file type: $extension"
    exit 1
fi

xdg-open "$url"
