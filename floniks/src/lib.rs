#![crate_name = "floniks"]
#![crate_type = "rlib"]

use {
  std::{ convert::TryFrom },
  async_std::{
    io::Error, io::ReadExt,
    fs::read, io::Result, path::Path,
  },
  serde::{ Serialize, Deserialize },
};

pub struct Proses {
    korz: usize,
}

impl Proses {
    pub fn niu() -> Self {
        Proses { korz: 1, }
    }
}
