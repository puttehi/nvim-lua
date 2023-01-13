#!/bin/bash

SCRIPT_PATH=docs/docs.lua
# LSP doesn't want to load for some reason but "just adding sleep" works around it.
# Without it loading, on_attach keybindings are lost.
nvim --headless $SCRIPT_PATH "+sleep 1" +so +q || exit 1

echo "Injected markdown table snippet to $PWD/README.md"
