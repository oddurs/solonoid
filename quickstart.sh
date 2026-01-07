#!/bin/bash

# Solonoid - Quick Start Script
# This script helps you get the project up and running quickly

set -e

echo "🎮 Welcome to Solonoid!"
echo "========================"
echo ""

# Check for Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode is not installed"
    echo "Please install Xcode from the App Store: https://apps.apple.com/app/xcode"
    exit 1
fi

echo "✅ Xcode found: $(xcodebuild -version | head -1)"
echo ""

# Check Swift version
SWIFT_VERSION=$(swift --version 2>/dev/null | awk '{print $NF}')
echo "✅ Swift version: $SWIFT_VERSION"
echo ""

# Get current directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "📁 Project directory: $PROJECT_DIR"
echo ""

# Build options
echo "🔨 Building Solonoid..."
echo ""
echo "Select build configuration:"
echo "1) Debug (recommended for development)"
echo "2) Release (optimized for performance)"
echo "3) Just open in Xcode (no build)"
echo "4) Clean and build"
echo ""
read -p "Enter choice [1-4]: " BUILD_CHOICE

case $BUILD_CHOICE in
    1)
        echo "Building Debug configuration..."
        xcodebuild -scheme "solonoid iOS" -configuration Debug
        echo "✅ Debug build complete!"
        ;;
    2)
        echo "Building Release configuration..."
        xcodebuild -scheme "solonoid iOS" -configuration Release
        echo "✅ Release build complete!"
        ;;
    3)
        echo "Opening in Xcode..."
        open "$PROJECT_DIR/solonoid.xcodeproj"
        exit 0
        ;;
    4)
        echo "Cleaning..."
        xcodebuild clean -scheme "solonoid iOS"
        echo "Building Debug configuration..."
        xcodebuild -scheme "solonoid iOS" -configuration Debug
        echo "✅ Clean build complete!"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "🎯 Next steps:"
echo "1. Open in Xcode: open solonoid.xcodeproj"
echo "2. Select a simulator or device"
echo "3. Press Cmd+R to run"
echo ""
echo "📚 Documentation:"
echo "- Read gameplay guide: docs/GAMEPLAY.md"
echo "- Learn architecture: docs/ARCHITECTURE.md"
echo "- Build instructions: docs/BUILD.md"
echo "- Contribution guide: docs/CONTRIBUTING.md"
echo ""
echo "Have fun! 🎮✨"
