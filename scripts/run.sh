#!/bin/bash

EXE="vcs"
EXE_PATH="target/release/$EXE"

echo -e "\e[36m[RUN] Launching VCS executable...\e[0m"

"$EXE_PATH"

echo -e "\e[36m=== Intelligent VCS Execution Complete ===\e[0m"

