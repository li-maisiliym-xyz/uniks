#![crate_name = "uniks"]
#![crate_type = "lib"]

use {
    async_std::{
        io::Error,
        os::unix::fs::symlink,
        path::{Path, PathBuf},
    },
    async_trait::async_trait,
    blake3::{Hash, Hasher},
    sajban::Link,
    serde::{Deserialize, Serialize},
    std::collections::HashMap,
};

#[derive(Serialize, Deserialize)]
pub enum Iuniks {
    Nixpkgs(Link),
    HomeManager(Link),
    Onspesyfaid(Link),
}

impl Iuniks {
    pub fn niu(link: Link) -> Self {}
}

#[derive(Serialize, Deserialize)]
pub struct LinkStatys {
    prezyns: Bool,
}

impl LinkStatys {
    pub fn niu(prezyns: Bool) -> Self {
        LinkStatys { prezyns }
    }
}

#[derive(Serialize, Deserialize)]
pub struct LinkStor {
    stor_path: Box<Path>,
    statys_map: HashMap<Link, LinkStatys>,
}

impl LinkStor {
    pub fn niu(kostym_path: Option<Path>) -> Self {
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
