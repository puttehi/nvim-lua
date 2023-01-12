#!/bin/bash

SCRIPT_PATH=docs/docs.lua
nvim --headless $SCRIPT_PATH +so +q

echo "Generated markdown table snippet to $PWD/.output.md"
