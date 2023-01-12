#!/bin/bash

SCRIPT_PATH=docs/docs.lua
nvim --headless $SCRIPT_PATH +so +q

echo "Injected markdown table snippet to $PWD/README.md"
