//
//  Player.swift
//  MacWar
//
//  Created by Jeremy Juan on 22/02/2019.
//  Copyright © 2019 Jeremy Juan. All rights reserved.
//

import Foundation

// Créons des class par centaines...
class Player {

    // MARK: - Properties

    let name: String
    private(set) var characters: [Character]
    
    
    // MARK: - Init class
    
    init(name: String) {
        self.name = name
        self.characters = []
    }
    
    
    // MARK: - Functions
    
    func addCharacter(character: Character) {
        
        characters.append(character)
        
    }
    
}