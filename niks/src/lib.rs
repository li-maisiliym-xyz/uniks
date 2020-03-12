use {
  async_std::{
    path::{ Path, PathBuf },
    os::unix::fs::symlink,
    io::Error,
  },
  serde::{ Deserialize, Serialize },
  async_trait::async_trait,
  std::collections::HashMap,
};

#[derive(Serialize, Deserialize)]
pub enum Niks {
  Clang(Option<Box<Path>>),
  Busybox(Option<Box<Path>>),
}

#[derive(Serialize, Deserialize)]
pub enum System {
  #[serde(rename = "x86_64-linux")]
  X86_64,
  #[serde(rename = "i686-linux")]
  I686,
  #[serde(rename = "aarch64-linux")]
  AARCH64,
  #[serde(rename = "armv7l-linux")]
  ARMV7L,
  #[serde(rename = "avr-linux")]
  AVR,
}

