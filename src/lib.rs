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
    sajban::{Hash, Hasher, Link},
    serde::{Deserialize, Serialize},
    std::collections::HashMap,
};

#[derive(Serialize, Deserialize)]
pub enum Uniks {
    Onspesyfaid(Link),
    RustModz(Link),
}

impl Uniks {
    pub fn niu() -> Self {
        Uniks::Onspesyfaid
    }
}

#[derive(Serialize, Deserialize)]
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
    statys_map: HashMap<Link, LinkStatys>,
}

impl LinkStor {
    pub fn niu(datom: Box<Datom>) -> Self {
        let statys_map: HashMap<Link, LinkStatys> = HashMap::new();
        LinkStor {
            statys_map,
            stor_path: match kostym_path {
                Some(Path) => Box::new(Path),
                None => Box::new(Path::new("/stor")),
            },
        }
    }
}
