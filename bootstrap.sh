#!/bin/bash
bash -c "$(curl -fsLS https://chezmoi.io/get)" -- -b "$HOME/.local/bin" init --apply
