//
//  SearchPokrmonViewController.swift
//  PokeDex
//
//  Created by Jake Connerly on 8/9/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class SearchPokemonViewController: UIViewController {
    
    //
    //MARK: - IBOutlets & Properties
    //


    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeTitleLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokeController: PokeController?
    
    var pokemon: Pokemon? {
        didSet {
            updateView()
        }
    }
    
    //
    //MARK: - View LifeCycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    //
    //MARK: - IBActions & Methods
    //
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }
    
    private func updateView() {
        
        guard let pokemon = pokemon else { return }
        
        var abilities: String = ""
        for ability in pokemon.abilities {
            abilities.append(contentsOf: "\(ability.ability.name) ")
        }
        
        var types: String = ""
        for type in pokemon.types {
            types.append(contentsOf: "\(type.type.name) ")
        }
        
        let imageURL = pokemon.sprites.frontDefault
        
        pokeController?.fetchPokemonImage(from: imageURL, completion: { result in
            do {
                let imageData = try result.get()
                let pokemonImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.pokeImageView.image = pokemonImage
                }
            }catch {
                NSLog("Error getting image:\(error)")
            }
        })
        
        pokeTitleLabel.text = pokemon.name
        IDLabel.text = String(pokemon.id)
        abilitiesLabel.text = abilities
        typeLabel.text = types
    }

}

//
//MARK: - Extensions
//

extension SearchPokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = pokeSearchBar.text?.lowercased(),
            !name.isEmpty,
            let pokeController = pokeController else { return }
        
        pokeController.fetchPokemon(with: name, completion: { result in
            
            do {
                let fetchedPokemon = try result.get()
                DispatchQueue.main.async {
                    self.pokemon = fetchedPokemon
                }
            }catch {
                NSLog("Error Getting pokemon when fetched in DetailView:\(error)")
            }
        })
    }
}
