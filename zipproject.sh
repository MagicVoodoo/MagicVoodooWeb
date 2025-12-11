#!/bin/bash

PROJECT_DIR="$(pwd)"
ZIP_NAME="MagicVoodooWeb.zip"

echo "Cleaning build artifacts..."
rm -rf "$PROJECT_DIR"/bin
rm -rf "$PROJECT_DIR"/obj
rm -rf "$PROJECT_DIR"/**/bin
rm -rf "$PROJECT_DIR"/**/obj

echo "Creating ZIP archive..."
cd ..
zip -r "$ZIP_NAME" "$(basename "$PROJECT_DIR")" \
    -x "*/bin/*" "*/obj/*" "*.DS_Store" "*.user" "*.suo" "*.cache" ".idea/*" ".vs/*" ".vscode/*"

echo "ZIP created: $(pwd)/$ZIP_NAME"
echo "👉 Drag and drop $ZIP_NAME into ChatGPT now."