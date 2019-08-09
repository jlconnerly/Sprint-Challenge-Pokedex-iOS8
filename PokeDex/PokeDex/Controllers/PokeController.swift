//
//  PokeController.swift
//  PokeDex
//
//  Created by Jake Connerly on 8/9/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation


class PokeController {
    
    //
    //MARK: - Enums
    //
    
    enum HTTPMethod: String {
        case get    = "GET"
        case put    = "PUT"
        case post   = "POST"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noAuth
        case badAuth
        case otherError(Error)
        case badData
        case noDecode
    }
    
    //
    //MARK: - Properties
    //
    
    var pokemonList: [Pokemon] = []
    
    let baseURL = URL(string: "http://poke-api.vapor.cloud/api/v2/")!
    
    //
    //MARK: - getPokemon
    //
    
    func fetchPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let requestURL = baseURL.appendingPathComponent("pokemon")
        requestURL.appendingPathComponent(name)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    NSLog("Response is not 200 response is: \(response.statusCode)")
                }
            }
            
            if let error = error {
                NSLog("Error fetching \(name):\(error)")
                completion(.failure(.otherError(error)))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned for \(name)")
                completion(.failure(.badData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            }catch {
                NSLog("Error decoding pokemon: \(name)")
                completion(.failure(.noDecode))
            }
            
            
            
        }.resume()
       
    }
    
    
    
}
