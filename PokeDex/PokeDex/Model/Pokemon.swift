//
//  Pokemon.swift
//  PokeDex
//
//  Created by Jake Connerly on 8/9/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let sprites: Sprites
    let types: [Type]
}

struct Ability: Codable {
    let ability: Name
}

struct Type: Codable {
    let type: Name
}

struct Name: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

