#![crate_name = "meikPod"]
#![crate_type = "bin"]

use niks::StructuredAttrs;

#[async_std::main]
async fn main() {
    let attrs = StructuredAttrs::get().await.unwrap();
    let pri_pod = ();
}
