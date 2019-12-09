//
//  PokemonViewController.swift
//  ImageLab
//
//  Created by Tsering Lama on 12/9/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    
    @IBOutlet weak var searchPokemon: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var pokemons = [Pokemon]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadData() {
        let getData = PokemonAPI.getPokemon { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let getData):
                DispatchQueue.main.async {
                    self.pokemons = getData
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? PokemonDetailVC, let indexpath = tableView.indexPathForSelectedRow else {
            return
        }
        detailVC.pokemon = pokemons[indexpath.row]
    }

}

extension PokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardTableViewCell else {
            fatalError()
        }
        let aCard = pokemons[indexPath.row]
        cell.configureCell(data: aCard)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
}
