#![crate_name = "meikPod"]
#![crate_type = "bin"]

use {niks::StructuredAttrs, uniks::async_main};

#[async_main]
async fn main() {
    let attrs = StructuredAttrs::get().await.unwrap();
    let pri_pod = ();
}
