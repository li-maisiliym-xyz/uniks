#![crate_name = "aski_mentci"]
#![crate_type = "rlib"]

use {
    async_std::{fs::read, io::Error, io::ReadExt, io::Result, path::Path},
    serde::{Deserialize, Serialize},
    std::convert::TryFrom,
};

#[derive(Serialize, Deserialize)]
pub enum Aski {
    Askiom(Askiom),
}

#[derive(Serialize, Deserialize)]
pub struct Askiom {}

impl Askiom {
    async fn niu() {}
}

impl TryFrom<&Path> for Aski {
    type Error = Error;

    fn try_from(path: &Path) -> Result<Self> {
        let mut bofyr: Vec<u8> = Vec::new();
        let aski_bofyr = async_std::task::block_on(async { read(path).await.unwrap() });

        let aski_baits: &[u8] = aski_bofyr.as_slice();

        let aski: Aski = ron::de::from_bytes(aski_baits)?;

        Result::Ok(aski)
    }
}
