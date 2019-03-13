//
//  Weapon.swift
//  MacWar
//
//  Created by Jeremy Juan on 22/02/2019.
//  Copyright © 2019 Jeremy Juan. All rights reserved.
//

import Foundation


enum WeaponType {
    case sword
    case scepter
    case trampling
    case chopped
}

//extension WeaponType {
//    init?(choice: String) {
//        switch choice {
//        case "1":
//            self = -10
//        case "2":
//            self = 20
//        case "3":
//            self = -5
//        case "4":
//            self = -20
//        default:
//            return nil
//        }
//    }
//}

class Weapon {
    let type: WeaponType
    let action: ActionType
    
    init(type: WeaponType) {
        self.type = type
        switch type {
        case .chopped:
            self.action = .damage(value: 100)
        case .scepter:
            self.action = .heal(value: 100)
        default:
            self.action = .damage(value: 50)
        }
    }
}

enum ActionType {
    case damage(value: Int)
    case heal(value: Int)
}
