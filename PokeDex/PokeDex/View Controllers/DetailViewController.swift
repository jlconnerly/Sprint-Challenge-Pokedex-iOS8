//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Jake Connerly on 8/9/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //
    //MARK: - IBOutlets & Properties
    //

    
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokeController: PokeController?
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        
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
                    self.pokeNameLabel.text = pokemon.name
                    self.IDLabel.text = String(pokemon.id)
                    self.abilitiesLabel.text = abilities
                    self.typeLabel.text = types
                    self.title = pokemon.name
                }
            }catch {
                NSLog("Error getting image:\(error)")
            }
        })
        
 
    }
}


