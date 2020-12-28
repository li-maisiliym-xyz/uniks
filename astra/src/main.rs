#![crate_name = "astra"]
#![crate_type = "bin"]

use {
    krios::{ PriKriom, Kriom, Kriod },
    uniks::{ IuniksMap, },
};


#[derive(Serialize, Deserialize)]
pub struct Astra {
    kriod: Kriod,
    praim_kriom: Kriom,
    raizyn: Raizyn
}

impl Astra {
    pub fn niu() -> Self {
        Astra {  }
    }
}

pub struct Raizyn {
    
}

impl Raizyn {
    pub fn niu() -> Self {
        Raizyn {  }
    }
}

#[derive(Serialize, Deserialize)]
pub struct PraimPod {
    astra: Astra,
    iuniks_map: IuniksMap,
    fleik: niks::Fleik,
}

pub fn main() {
    let astra = match Astra::tryFromFS() {
        Ok(astra) => astra,
        Err(e) => Astra::init(),
    };

}
