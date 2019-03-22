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
    
    func updateLife(with action: ActionType, characterType: CharacterType, bonus: Int) {
        switch action {
        case .damage(value: var value):
            if bonus == 0 {
                value *= 2
            } else if bonus == 1{
                value /= 2
            }
            if value > self.life {
                self.life = 0
            } else {
                self.life -= value
            }
        case .heal(value: var value):
            if bonus == 0 {
                value *= 2
            } else if bonus == 1{
                value /= 2
            }
            let tempValue = value + self.life
            let initLife: Int
            switch characterType {
            case .warrior:
                initLife = 100
            case .magus:
                initLife = 50
            case .colossus:
                initLife = 150
            case .dwarf:
                initLife = 30
            }
            if tempValue >= initLife {
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
            } else if self.life > 0 && tempValue < initLife {
                self.life += value
            } else {
                self.life = 0
            }
        }
    }
}
