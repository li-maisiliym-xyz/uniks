use std::collections::HashMap;

#[derive(Serialize, Deserialize)]
pub struct Spiniks {}

impl Spiniks {
    async fn spinop() -> Result<PodStatys> {}

    async fn spindaun() -> Result<PodStatys> {}
}

pub fn main() {
    let argz: Args = args();
    let fyrst_arg = argz.skip(1).next();
}
