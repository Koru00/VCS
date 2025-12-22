use std::env;
use std::fs;
use std::path::{Path, PathBuf};

fn main() {
    let profile = env::var("PROFILE").unwrap(); // debug o release
    let target_dir = PathBuf::from("target").join(&profile);

    let src = Path::new("python");
    let dst = target_dir.join("python");

    if dst.exists() {
        fs::remove_dir_all(&dst).unwrap();
    }

    copy_dir_all(src, &dst).unwrap();

    println!("cargo:rerun-if-changed=python");
}

fn copy_dir_all(src: &Path, dst: &Path) -> std::io::Result<()> {
    fs::create_dir_all(dst)?;
    for entry in fs::read_dir(src)? {
        let entry = entry?;
        let ty = entry.file_type()?;
        if ty.is_dir() {
            copy_dir_all(&entry.path(), &dst.join(entry.file_name()))?;
        } else {
            fs::copy(&entry.path(), &dst.join(entry.file_name()))?;
        }
    }
    Ok(())
}
