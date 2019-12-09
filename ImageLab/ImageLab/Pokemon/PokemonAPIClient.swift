//
//  PokemonAPI.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct PokemonAPI {
    
    static func getPokemon (completionHandler: @escaping (Result<[Pokemon], AppError>) -> ()) {
        
        let pokemonURL = "https://api.pokemontcg.io/v1/cards"
        var pokemons = [Pokemon]()
        
        NetworkHelper.shared.performDataTask(userurl: pokemonURL) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                do {
                    let pokemonDatas = try JSONDecoder().decode(PokemonData.self, from: data)
                    pokemons = pokemonDatas.cards
                    completionHandler(.success(pokemons))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
