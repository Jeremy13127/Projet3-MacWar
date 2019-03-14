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
    
    func initializeCharacters(characters: [Character]) {
        self.characters = characters
    }
    
    func tableOfCharacterCount() -> Int {
        let count = self.characters.count
        return count
    }
    
}
