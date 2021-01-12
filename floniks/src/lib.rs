#![crate_name = "floniks"]
#![crate_type = "rlib"]

use {
    async_std::{fs::read, io::Error, io::ReadExt, io::Result, path::Path},
    serde::{Deserialize, Serialize},
};

#[derive(Serialize, Deserialize)]
pub struct Proses {
    korz: usize,
}

impl Proses {
    pub fn niu() -> Self {
        Proses { korz: 1 }
    }
}
