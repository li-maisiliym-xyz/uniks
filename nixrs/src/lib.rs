use {
  std::collections::HashMap,
  async_std::{
    fs::read,
    io::Result,
    path::Path,
  },
  serde_json::Value,
};

#[derive(serde::Serialize, serde::Deserialize)]
pub struct StructuredAttrs {
  name: String,
  builder: Box<Path>,
  system: System,

  #[serde(flatten)]
  extra: HashMap<String, Value>,
}

#[derive(serde::Serialize, serde::Deserialize)]
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

impl StructuredAttrs {
  async fn get() -> Result<Self> {
    let iuniks: &Path = Path::new("./.attrs.json");
    let json_bofyr: Vec<u8> = read(iuniks).await.unwrap();
    let slice: &[u8] = json_bofyr.as_slice();
    let value: StructuredAttrs = serde_json::from_slice(slice).unwrap();
    Result::Ok(value)
  }
}