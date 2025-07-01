.PHONY: help setup build run release dev build-android-release clean

help:
	@echo "Makefile for Capacitor Hello World"
	@echo ""
	@echo "Usage:"
	@echo "  make help                   - Show this help message"
	@echo "  make setup                  - Install all dependencies needed to run the app on macOS"
	@echo "  make build                  - Build web assets and sync with native platforms"
	@echo "  make run                    - Run the app on Android"
	@echo "  make release                - Open the Android project in Android Studio to prepare a release"
	@echo "  make dev                    - Sync changes and open the Android project for development"
	@echo "  make clean                  - Clean the project by removing generated files and dependencies"

	@echo "  make build-android-release  - Build the Android release distribution (AAB)"

setup:
	@echo "Setting up development environment for macOS..."
	@echo "This will install dependencies using Homebrew and npm."
	@if ! command -v brew >/dev/null; then \
		echo "Error: Homebrew not found. Please install it first by running:"; \
		echo '  /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'; \
		exit 1; \
	fi
	@echo "\n--- Step 1: Installing Java (OpenJDK) via Homebrew ---"
	brew install openjdk
	@echo "\n--- Step 2: Installing Android Studio via Homebrew ---"
	@echo "This will install the full Android IDE, which is the recommended way to manage the Android SDK."
	brew install --cask android-studio
	@echo "\n--- Step 3: Installing npm packages ---"
	npm install -g @capacitor/cli native-run
	npm install
	@echo "\n--- Setup Almost Complete! ---"
	@echo "\n[IMPORTANT] Manual steps required:"
	@echo "1. Open Android Studio. It will guide you through the initial Android SDK setup."
	@echo "   You can find it in your Applications folder."
	@echo "2. Configure environment variables for your shell, then restart your terminal."
	@echo "   The SDK is usually at '$$HOME/Library/Android/sdk'."
	@echo ""
	@echo "   For bash/zsh (add to ~/.zshrc or ~/.bash_profile):"
	@echo "     export ANDROID_SDK_ROOT=\"$$HOME/Library/Android/sdk\""
	@echo "     export PATH=\"$$PATH:$$ANDROID_SDK_ROOT/tools:$$ANDROID_SDK_ROOT/platform-tools\""
	@echo ""
	@echo "   For fish shell (add to ~/.config/fish/config.fish):"
	@echo "     set -x ANDROID_SDK_ROOT \"$$HOME/Library/Android/sdk\""
	@echo "     fish_add_path \"$$ANDROID_SDK_ROOT/tools\" \"$$ANDROID_SDK_ROOT/platform-tools\""
	@echo ""
	@echo "3. After restarting your terminal, accept the SDK licenses:"
	@echo "   yes | sdkmanager --licenses"

build:
	@echo "Building web assets and syncing with native platforms..."
	npx cap sync

run:
	@echo "Running the app on Android..."
	JAVA_HOME=/usr/local/Cellar/openjdk@17/17.0.15/libexec/openjdk.jdk/Contents/Home npx cap run android

release:
	@echo "Opening the Android project in Android Studio to prepare a release..."
	npx cap open android

dev:
	@echo "Syncing changes and opening the Android project for development..."
	npx cap sync
	npx cap open android

build-android-release:
	@echo "Building Android release (AAB)..."
	@echo "Note: This requires you to have configured signing keys for your Android project."
	cd android && ./gradlew bundleRelease

clean:
	@echo "Cleaning the project..."
	@echo "Removing node_modules..."
	rm -rf node_modules
	@echo "Cleaning Android project..."
	@if [ -f "android/gradlew" ]; then \
		cd android && ./gradlew clean; \
	else \
		echo "Android project not found, skipping clean."; \
	fi
	@echo "Project cleaned."