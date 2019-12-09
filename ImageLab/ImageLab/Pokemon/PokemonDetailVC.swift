//
//  DetailViewController.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var cardImages: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var weaknessText: UILabel!
    @IBOutlet weak var setText: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()

    }
    
    func loadUI() {
        nameText.text = pokemon.name
        typeText.text = pokemon.types?.first
        weaknessText.text = pokemon.weakness?.description
        setText.text = pokemon.set
        
        NetworkHelper.shared.performDataTask(userurl: pokemon.imageUrlHiRes) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.cardImages.image = image
                }
            }
        }
    }


}
