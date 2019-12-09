//
//  AppError.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

enum AppError: Error {
    
    case badURl(String)
    case noResponse
    case networkClinetError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMIMEType
    
}
