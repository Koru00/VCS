#!/bin/bash

# Colori ANSI (funzionano sulla maggior parte dei terminali Linux)
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== Intelligent VCS Runner ===${NC}"

# Paths (adattati per Linux - assumendo che stai buildando nativamente per Linux)
rust_lib_dir="target/release"          # Su Linux, cargo build --release mette la lib qui (o .a/.rlib)
rust_lib_name="core_rust"
exe="vcs"                              # Senza .exe su Linux
exe_path="build/release/$exe"
include_path="src/module_c/include"

# Crea la directory di build se non esiste
mkdir -p "build/release"

# --- Build Rust ---
echo -e "${YELLOW}[BUILD] Compiling Rust in release mode${NC}"
pushd "src/" > /dev/null || { echo -e "${RED}[ERROR] Cannot enter src/ directory${NC}"; exit 1; }

cargo build --release
if [ $? -ne 0 ]; then
    popd > /dev/null
    echo -e "${RED}[ERROR] Rust build failed.${NC}"
    exit 1
fi

popd > /dev/null
