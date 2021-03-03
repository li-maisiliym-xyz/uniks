#![crate_name = "aybzorb"]
#![crate_type = "bin"]

use {
    async_std::{
        io::Error,
        os::unix::fs::symlink,
        path::{Path, PathBuf},
    },
    serde::{Deserialize, Serialize},
    std::{collections::HashMap, env::args},
};

#[derive(Serialize, Deserialize)]
pub struct Aybzorpcyn {
    metyl_storz: MetylStorz,
}

#[derive(Serialize, Deserialize)]
pub struct MetylStorz {
    boot: MetylStor,
    nix: MetylStor,
    home: MetylStor,
}

#[derive(Serialize, Deserialize)]
pub enum MetylStor {
    Xfs(XfsStor),
    Stratis(StratisStor),
}

#[derive(Serialize, Deserialize)]
pub struct XfsStor {
    disk: Disk,
}

#[derive(Serialize, Deserialize)]
pub struct StratisStor {}

impl Aybzorpcyn {
    pub fn niu() -> Self {
        Aybzorpcyn {}
    }
}

fn kostym_aybzorb(path: String) {
    let path: &Path = Path::new(fyrst_arg);
    let aybzorpcyn = Aybzorpcyn::TryFrom();
}

fn main() {
    let argz: Args = args();
    let fyrst_arg = argz.skip(1).next();

    match fyrst_arg {
        Some(s) => kostym_aybzorb(s),
        None() => oto_aybzorb(),
    }
}
