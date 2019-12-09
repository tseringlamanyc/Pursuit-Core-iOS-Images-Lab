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
    
    var comicInts: Double = 614
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepper()
        loadComics(issue: Int(comicStepper.value))
    }
    
    func configureStepper() {
        comicStepper.maximumValue = Double(comics.last?.num ?? 624)
        comicStepper.minimumValue = Double(comics.first?.num ?? 614)
        comicStepper.value = Double(comics.first?.num ?? 614)
        comicStepper.stepValue = 1.0
    }
    
    func loadComics(issue: Int) {
        let getComics = ComicAPI.getComics(comicInt: issue) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let getComics):
                DispatchQueue.main.async {
                    self.userText.text = "Issue number: \(getComics.num.description)"
                    self.loadImage(urlString: getComics.img)
                    self.comicStepper.value = Double(getComics.num)
                }
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
    
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        loadComics(issue: Int(sender.value))
    }
    
    
}

