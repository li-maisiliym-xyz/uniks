#![crate_name = "meikPod"]
#![crate_type = "bin"]

use niks::{StructuredAttrs, Value};
use uniks::{IuzyrPod, Pod};

#[async_std::main]
async fn main() {
    let input = StructuredAttrs::get().await.unwrap();
    let pod: Pod = ();
}
