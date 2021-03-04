#![crate_name = "iuniks"]
#![crate_type = "lib"]

#[derive(Serialize, Deserialize)]
pub enum Iuniks {
    NioviTri(NioviTri),
}
