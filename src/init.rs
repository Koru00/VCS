use std::fs;
use std::io;
use std::path::PathBuf;

pub fn init_vcs(path: Option<PathBuf>) -> io::Result<()> {
    let mut dir_path = match path {
        Some(p) => p,
        None => std::env::current_dir()?,
    };

    dir_path = dir_path.join(".vcs");

    fs::create_dir_all(&dir_path)?;

    Ok(())
}
