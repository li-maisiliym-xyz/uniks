#![crate_name = "askiom_derive"]
#![crate_type = "proc-macro"]

use {
    aski::Askiom,
    async_std::{io::Error, path::Path, task},
    proc_macro::TokenStream,
    proc_macro2, quote,
};

#[proc_macro_attribute]
pub fn roskiomaiz(input: TokenStream) -> TokenStream {
    TokenStream::from(djenyreit_TokenStream2().unwrap())
}

fn djenyreit_tokenstream2() -> Result<proc_macro2::TokenStream, Error> {
    let askiom: Askiom = task::spawn(async {
        let ruskiom_path: &Path = Path::new("./roskiom.aski");
        Askiom::rid(ruskiom_path).await?
    });
}
