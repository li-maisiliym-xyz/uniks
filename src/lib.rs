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
pub struct IuniksStatys {
    prezyns: Bool,
}

impl IuniksStatys {
    pub fn niu(prezyns: Bool) -> Self {
        IuniksStatys { prezyns, }
    }
}

#[derive(Serialize, Deserialize)]
pub struct IuniksStor {
    storPath: Box<Path>,
    statysMap: HashMap<Iuniks, IuniksStatys>,
}

impl IuniksStor {
    pub fn niu() -> Self {
        IuniksStor {
            stor: HashMap::new(),
        }
    }
}
