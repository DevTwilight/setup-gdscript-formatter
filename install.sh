set -euo pipefail

if [[ "$RUNNER_OS" == "Windows" ]]; then
    BINARY="gdscript-formatter.exe"
else
    BINARY="gdscript-formatter"
fi

case "$RUNNER_OS" in
    Linux)
        OS="linux"
        ;;
    macOS)
        OS="macos"
        ;;
    Windows)
        OS="windows"
        ;;
    *)
        echo "Unsupported operating system: $RUNNER_OS"
        exit 1
        ;;
esac

case "$RUNNER_ARCH" in
    X64)
        ARCH="x86_64"
        ;;
    ARM64)
        ARCH="aarch64"
        ;;
    *)
        echo "Unsupported architecture: $RUNNER_ARCH"
        exit 1
        ;;
esac

if [[ "$RUNNER_OS" == "Windows" ]]; then
    ARCHIVE="gdscript-formatter-$VERSION-$OS-$ARCH.exe.zip"
    SOURCE_BINARY="gdscript-formatter-$VERSION-$OS-$ARCH.exe"
else
    ARCHIVE="gdscript-formatter-$VERSION-$OS-$ARCH.zip"
    SOURCE_BINARY="gdscript-formatter-$VERSION-$OS-$ARCH"
fi

URL="https://github.com/GDQuest/GDScript-formatter/releases/download/$VERSION/$ARCHIVE"

mkdir -p "$INSTALL_DIR"

TMP_DIR="$(mktemp -d)"
TMP_ARCHIVE="$TMP_DIR/formatter.zip"

trap 'rm -rf "${TMP_DIR:-}"' EXIT

echo "Downloading GDScript Formatter $VERSION for $OS-$ARCH..."
curl -fsSL "$URL" -o "$TMP_ARCHIVE"

echo "Extracting Archive..."

if [[ "$RUNNER_OS" == "Windows" ]]; then
    7z x "$TMP_ARCHIVE" -o"$TMP_DIR" -y >/dev/null
else
    unzip -q "$TMP_ARCHIVE" -d "$TMP_DIR"
fi

echo "Installing GDScript Formatter"
echo "Install directory: $INSTALL_DIR"

mv "$TMP_DIR/$SOURCE_BINARY" "$INSTALL_DIR/$BINARY"

if [[ "$RUNNER_OS" != "Windows" ]]; then
    chmod +x "$INSTALL_DIR/$BINARY"
fi

echo "Adding GDScript Formatter to PATH"
echo "$INSTALL_DIR" >> "$GITHUB_PATH"

echo "GDScript Formatter installed successfully."