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
    let types: [TypeElement]
}

struct Ability: Codable {
    let ability: Species
}

struct TypeElement: Codable {
    let type: Species
}

struct Species: Codable {
    let name: String
}

