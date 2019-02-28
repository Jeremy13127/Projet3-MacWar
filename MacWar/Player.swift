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

    let name: String

    private(set) var characters: [Character]
    
    init(name: String) {
        self.name = name
        self.characters = []
    }
    
    func addCharacter(character: Character) {
        characters.append(character)
        
        // Boucle x3 personnages dans la partie
        /*
         repeat {
         count2 += 1
         
         print("Choisissez un nom de personnage \(count2):")
         characterName = readLine()!
         print("vous avez choisi comme nom de personnage: \(characterName)")
         
         print("Choisissez un type de personnage :")
         print("1 - warrior")
         print("2 - magus")
         print("3 - colossus")
         print("4 - dwarf")
         characterType = readLine()!
         print("vous avez choisi comme nom de personnage: \(characterType)")
         
         let character = Character(type: CharacterType, name: characterName)
         characters.append(character)
         
         } while count2 < 3
         */
        
    }
    
    func ListOfCharacter(character: Character) {
        // Listing de tous les personnages et leurs points de vie du joueur
        characters.forEach { (character) in
            print(character.name)
        }
    }
}
