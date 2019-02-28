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
    
    init(type: CharacterType, name: String) {
        self.type = type
        self.name = name
    }
    
    func attack(){
        //
    }
    
}
