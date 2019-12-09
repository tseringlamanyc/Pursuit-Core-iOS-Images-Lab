//
//  NetworkHelper.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    private init() {
        session = URLSession.init(configuration: .default)
    }
    
    func performDataTask(userurl: String, completionHandler: @escaping (Result<Data,AppError>) -> ()) {
        
        guard let url = URL(string: userurl) else {
            completionHandler(.failure(.badURl(userurl)))
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(.networkClinetError(error)))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completionHandler(.failure(.badStatusCode(urlResponse.statusCode)))
                return
            }
            
            completionHandler(.success(data))
        }
        dataTask.resume()
    }
}
