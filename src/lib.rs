#![crate_name = "uniks"]
#![crate_type = "lib"]

pub use {
    async_std::{
        fs::read,
        io::Error,
        io::Result,
        os::unix::fs::symlink,
        path::{Path, PathBuf},
    },
    async_trait::async_trait,
    key_vec::KeyVec,
    sajban::{Hash, Hasher, Link},
    serde::{Deserialize, Serialize},
};

#[derive(Serialize, Deserialize)]
pub enum Uniks {
    Onspesyfaid(Link),
    RustModz(Link),
}

impl Uniks {}

#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Serialize, Deserialize)]
pub struct LinkStatys {
    prezyns: bool,
}

impl LinkStatys {
    pub fn niu(prezyns: bool) -> Self {
        LinkStatys { prezyns }
    }
}

#[derive(Serialize, Deserialize)]
pub struct LinkStor {
    stor_path: Box<Path>,
    statys_map: KeyVec<Link, LinkStatys>,
}

impl LinkStor {}
