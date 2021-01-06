#![crate_name = "uniks"]
#![crate_type = "lib"]

use {
    async_std::{
        path::{ Path, PathBuf },
        os::unix::fs::symlink,
        io::Error,
    },
    serde::{ Deserialize, Serialize },
    async_trait::async_trait,
    std::collections::HashMap,
    blake3::{ Hash, Hasher },
    sajban::Link,
};

#[derive(Serialize, Deserialize)]
pub enum Iuniks {
    Nixpkgs(Link),
    HomeManager(Link),
    Onspesyfaid(Link),
}

impl Iuniks {
    pub fn niu(link: Link) -> Self { }
}

#[derive(Serialize, Deserialize)]
pub struct LinkStatys {
    prezyns: Bool,
}

impl LinkStatys {
    pub fn niu(prezyns: Bool) -> Self {
        LinkStatys { prezyns, }
    }
}

#[derive(Serialize, Deserialize)]
pub struct LinkStor {
    storPath: Box<Path>,
    statysMap: HashMap<Link, LinkStatys>,
}

impl LinkStor {
    pub fn niu() -> Self {
        LinkStor {
            stor: HashMap::new(),
        }
    }
}
