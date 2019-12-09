//
//  ViewController.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var comicStepper: UIStepper!
    
    var comics = [Comics]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepper()
    }
    
    func configureStepper() {
        comicStepper.maximumValue = 624
        comicStepper.minimumValue = 614
        comicStepper.value = 614
    }
    
    func loadComics(issue: Int) {
        let getComics = ComicAPI.getComics(comicInt: issue) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let getComics):
                self.comics = getComics
            }
        }
       
    }
    
    func loadImage(urlString: String) {
        NetworkHelper.shared.performDataTask(userurl: urlString) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.comicImage.image = image
                }
            }
        }
    }


}

