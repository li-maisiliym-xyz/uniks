#![crate_name = "spiniks"]
#![crate_type = "bin"]

use {
    async_std::{fs::read, io::Result, path::Path, task::block_on},
    std::{collections::HashMap, env::args},
};

#[derive(Serialize, Deserialize)]
pub struct Spiniks {}

impl Spiniks {
    async fn spinop() -> Result<PodStatys> {}
    async fn spindaun() -> Result<PodStatys> {}
}

impl TryFrom<&Path> for Spiniks {
    type Error = Error;

    fn try_from(path: &Path) -> Result<Self> {
        let mut bofyr: Vec<u8> = Vec::new();
        let spiniks_bofyr = block_on(async { read(path).await.unwrap() });
        let spiniks_baits: &[u8] = spiniks_bofyr.as_slice();
        let spiniks: spiniks = ron::de::from_bytes(spiniks_baits)?;
        Result::Ok(spiniks)
    }
}

pub fn main() {
    let argz: Args = args();
    let fyrst_arg = argz.skip(1).next();
    let path: &Path = Path::new(fyrst_arg);
}
