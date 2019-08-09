//
//  MainPokemonViewController.swift
//  PokeDex
//
//  Created by Jake Connerly on 8/9/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class MainPokemonViewController: UIViewController {
    
    //
    //MARK: - IBOutlets & Properties
    //

    @IBOutlet weak var tableView: UITableView!
    
    let pokeController = PokeController()
    
    //
    //MARK: - View LifeCycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
    }
    

    //
    // MARK: - Navigation
    //
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
    
    //
    //MARK: - IBActions & Methods
    //
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
    }
    
}

//
//MARK: - Extensions
//

extension MainPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeController.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath)
        let pokemon = pokeController.pokemonList[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    
}
