//
//  CardTableViewCell.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!
    
    var pokemon: Pokemon!
    
    func configureCell(data: Pokemon) {
        
        NetworkHelper.shared.performDataTask(userurl: data.imageUrl) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.cardImage.image = image
                }
            }
        }
    }
    
}
