//
//  Character.swift
//  MacWar
//
//  Created by Jeremy Juan on 22/02/2019.
//  Copyright © 2019 Jeremy Juan. All rights reserved.
//

import Foundation

enum CharacterType {
    case warrior
    case magus
    case colossus
    case dwarf
}

extension CharacterType {
    init?(choice: String) {
        switch choice {
        case "1":
            self = .warrior
        case "2":
            self = .magus
        case "3":
            self = .colossus
        case "4":
            self = .dwarf
        default:
            return nil
        }
    }
}

class Character {
    
    let type: CharacterType
    let name: String
    var life: Int
    
    init(name: String, type: CharacterType) {
        self.name = name
        self.type = type
        switch type {
        case .warrior:
            self.life = 100
        case .magus:
            self.life = 50
        case .colossus:
            self.life = 150
        case .dwarf:
            self.life = 30
        }
    }
    
    func updateLife(with weapon: Weapon) {
        switch weapon.action {
        case .damage(value: let value):
            // Gérer il faut que la value soit > a la vie restante
            // Si .damage est supérieur à self.life, alors self.life = 0
            // Sinon self.life -= value
            if value > self.life {
                self.life = 0
            }
            if value > self.life {
                self.life -= value
            }
        case .heal(value: let value):
            // Gérer il faut que la value soit > a la vie originale
            // Si .heal est supérieur à self.life, alors self.life = 100
            // Sinon self.life += value
            if value > self.life {
                self.life = 100
            }
            else {
                self.life += value
            }
            
        }
    }
}
