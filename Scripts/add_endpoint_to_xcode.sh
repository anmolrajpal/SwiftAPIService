# Scripts/add_endpoint_to_xcode.sh
#!/bin/bash

# Find the first .xcodeproj in the current directory
PROJECT_FILE=$(find . -name "*.xcodeproj" | head -n 1)

if [ -z "$PROJECT_FILE" ]; then
  echo "No Xcode project found in the current directory."
  exit 1
fi

# Infer the project name and path
PROJECT_NAME=$(basename "$PROJECT_FILE")
PROJECT_PATH=$(dirname "$PROJECT_FILE")

# Use xcodeproj gem to find the first target
TARGET_NAME=$(ruby -r xcodeproj -e "puts Xcodeproj::Project.open('$PROJECT_FILE').targets.first.name")

if [ -z "$TARGET_NAME" ]; then
  echo "No targets found in the Xcode project."
  exit 1
fi

FILE_PATH="Endpoint.swift"

# Add the file to the project using xcodeproj
xcodeproj "$PROJECT_NAME" --target "$TARGET_NAME" --add-file "$FILE_PATH"
