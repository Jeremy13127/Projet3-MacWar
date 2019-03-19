//
//  Weapon.swift
//  MacWar
//
//  Created by Jeremy Juan on 22/02/2019.
//  Copyright © 2019 Jeremy Juan. All rights reserved.
//

import Foundation


enum WeaponType: Int {
    case sword = 0
    case scepter = 1
    case trampling = 2
    case chopped = 3
}

extension WeaponType {
    init?(choice: Int) {
        switch choice {
        case 0:
            self = .sword
        case 1:
            self = .scepter
        case 2:
            self = .trampling
        case 3:
            self = .chopped
        default:
            return nil
        }
    }
}

class Weapon {
    let type: WeaponType
    let action: ActionType
    
    init(type: WeaponType) {
        self.type = type
        switch type {
        case .sword:
            self.action = .damage(value: 10)
        case .scepter:
            self.action = .heal(value: 20)
        case .trampling:
            self.action = .damage(value: 5)
        case .chopped:
            self.action = .damage(value: 20)
        }
    }
}

enum ActionType {
    case damage(value: Int)
    case heal(value: Int)
}
