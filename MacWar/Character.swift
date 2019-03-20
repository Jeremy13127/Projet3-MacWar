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
    var weapon: Weapon
    
    init(name: String, type: CharacterType) {
        self.name = name
        self.type = type
        switch type {
        case .warrior:
            self.weapon = Weapon(type: .sword)
            self.life = 100
        case .magus:
            self.weapon = Weapon(type: .scepter)
            self.life = 50
        case .colossus:
            self.weapon = Weapon(type: .trampling)
            self.life = 150
        case .dwarf:
            self.weapon = Weapon(type: .chopped)
            self.life = 30
        }
    }
    
    func updateLife(with action: ActionType, characterType: CharacterType) {
        switch action {
        case .damage(value: let value):
            if value > self.life {
                self.life = 0
            } else {
                self.life -= value
            }
        case .heal(value: let value):
            let tempValue = value + self.life
            if tempValue > self.life {
                switch characterType {
                case .warrior:
                    self.life = 100
                case .magus:
                    self.life = 50
                case .colossus:
                    self.life = 150
                case .dwarf:
                    self.life = 30
                }
            } else {
                self.life += value
            }
        }
    }
}
