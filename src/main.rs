use std::env;
use clib::Command;
mod init;

fn main() {  
    init::init_vcs(None);
}
