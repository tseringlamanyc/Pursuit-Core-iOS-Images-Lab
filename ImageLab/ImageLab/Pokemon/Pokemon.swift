//
//  Pokemon.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct PokemonData: Decodable {
    let cards: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let types: [String]?
    let set: String
    let imageUrlHiRes: String
    let imageUrl: String
    let weakness: [weaknesses]?
}

struct weaknesses: Decodable {
    let type: String
    let value: String
}
