#!/bin/bash

KEYMAPS_SCRIPT_PATH=docs/remap.lua
PACKER_SCRIPT_PATH=docs/packer.lua
# LSP doesn't want to load for some reason but "just adding sleep" works around it.
# Without it loading, on_attach keybindings are lost.
nvim --headless $KEYMAPS_SCRIPT_PATH "+sleep 1" +so +q || exit 1
echo "Injected keymaps markdown table snippet to $PWD/README.md"

nvim --headless $PACKER_SCRIPT_PATH +so +q || exit 1
echo "Injected packer markdown table snippet to $PWD/README.md"
