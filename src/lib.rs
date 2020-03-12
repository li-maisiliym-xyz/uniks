#![crate_name = "uniks"]
#![crate_type = "rlib"]

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

mod astra { 
  #[derive(serde::Serialize, serde::Deserialize)]
  pub enum Tri { }
}

mod etc { 
  #[derive(serde::Serialize, serde::Deserialize)]
  pub enum Tri { }
}

mod hom {
  #[derive(serde::Serialize, serde::Deserialize)]
  pub enum Tri { }
}

#[derive(Serialize, Deserialize)]
pub enum Uniks {
  Rysolv(Rysolv),
  OS(OS),
  Pod(Pod),
}

#[derive(Serialize, Deserialize)]
pub enum Tri {
  Astra(astra::Tri),
  Hom(hom::Tri),
  Etc(etc::Tri),
}

#[derive(Serialize, Deserialize)]
pub enum Brenc {
  Sobtri(Box<Tri>),

}

#[derive(Serialize, Deserialize)]
pub struct Rysolv {
  pub niksiz: Option<HashMap<String, niks::Niks>>,
  pub uniksiz: Option<HashMap<String, Uniks>>,
}

#[derive(Serialize, Deserialize)]
pub struct OS { }

#[derive(Serialize, Deserialize)]
pub struct Pod {
}

#[derive(Serialize, Deserialize)]
pub struct LinkTri {
  pub target: Box<Path>,
  pub nixiz: Option<HashMap<String, Box<Path>>>,
  pub iuniksiz: Option<HashMap<String, Iuniks>>,
}

#[derive(Serialize, Deserialize)]
pub enum Iuniks {
  Eksek(Box<Path>),
  Lib(Box<Path>),
}

impl LinkTri {
  pub async fn link(self) -> Result<(), Error>
  {
    let target_path = self.target;

    if let Some(link_map) = self.nixiz {
      for (dest_sufiks, nix) in link_map.iter() {
        let ful_dest: PathBuf = target_path.join(dest_sufiks);
        symlink(nix, ful_dest).await?
      }
    }

    Result::Ok(())
  }
}

#[derive(Serialize, Deserialize)]
pub struct Proses { }

#[async_trait]
trait Riylaizyr {
  async fn riylaiz(&self) -> Iuniks;
}
