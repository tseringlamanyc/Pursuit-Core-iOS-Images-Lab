//
//  ComicsAPIClient.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

struct ComicAPI {
    
    static func getComics(comicInt: Int, completionHandler: @escaping (Result<[Comics], AppError>)->()) {
        
        let comicURL = "http://xkcd.com/\(comicInt)/info.0.json"
        var comics = [Comics]()
        
        NetworkHelper.shared.performDataTask(userurl: comicURL) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                do {
                    let comicDatas = try JSONDecoder().decode([Comics].self, from: data)
                    comics = comicDatas
                    completionHandler(.success(comics))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
        
        
    
}
