# Capacitor Hello World

This is a simple "Hello World" application built with [Capacitor](https://capacitorjs.com/) to demonstrate how to run a web application natively on Android.

## Project Structure

- `www/`: Contains the web assets (`index.html`).
- `android/`: The native Android project.
- `capacitor.config.json`: Capacitor configuration file.
- `package.json`: npm dependencies and scripts.
- `Makefile`: Contains helper commands for managing the project.

## Prerequisites

- [Node.js](https://nodejs.org/)
- [Homebrew](https://brew.sh/) (for macOS)
- Android Studio and Android SDK

## Setup

To set up the development environment and install all dependencies, run:

```sh
make setup
```

This command will:
1. Install OpenJDK.
2. Install Android Studio.
3. Install global and local npm packages.

**Note:** After running `make setup`, you will need to perform a few manual steps, such as setting up the Android SDK in Android Studio and configuring environment variables. Follow the instructions displayed in the terminal.

## Available Commands

This project uses a `Makefile` to simplify common tasks.

- `make build`: Build web assets and sync them with the native Android project.
- `make run`: Run the application on a connected Android device or emulator.
- `make dev`: Sync web asset changes and open the Android project in Android Studio for development.
- `make release`: Open the Android project in Android Studio to prepare a release build.
- `make build-android-release`: Build a signed Android App Bundle (AAB) for release.
- `make clean`: Remove generated files and dependencies (`node_modules`, Android build files).
- `make help`: Show all available commands.
