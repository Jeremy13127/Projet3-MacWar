//
//  game.swift
//  MacWar
//
//  Created by Jeremy Juan on 26/02/2019.
//  Copyright © 2019 Jeremy Juan. All rights reserved.
//

import Foundation

class Game {
    
    // MARK: - Properties
    
    var players: [Player] = []
    var playerNames: [String] = []
    
    // MARK: - Game logic
    
    func start() {
        setting()
    }
    
    func setting() {
        
        print("Bonjour le jeu se lance!")

        for playerIndex in 1..<3 { // Boucle x2 joueurs dans la partie

            let player = createPlayer(for: playerIndex)

            // Création des personnages de la partie
            repeat {
                player.addCharacter(character: Character(type: .colossus, name: "Toto"))
            } while true
            
            players.append(player)
            
            print("Voici la liste des joueurs: ")
            players.forEach { (player) in
                print(player.name)
            }
        }
        
        play()
    }
    
    func play() {
        
        print("Bonjour le jeu commence!")
        
        end()
    }
    
    func end() {
        // Afficher le recap
        
        print("Bonjour le jeu se termine!")
    }

    // MARK: - Helpers

    private func createPlayer(for index: Int) -> Player {
        var playerNameCounter = 0
        var playerName: String = ""
        repeat {
            if playerNameCounter == 0 {
                // Création des personnages de la partie
                print("Choisissez un nom de joueur \(index):")
            } else {
                print("Merci d'entrer un nom valide")
            }
            
            if let _playerName = readLine() {
                print("vous avez choisi comme nom de joueur: \(playerName)")
                playerName = _playerName
                playerNames.append(_playerName)
            } else {
                playerName = ""
            }
            
            playerNameCounter += 1
        } while playerName == "" && !playerNames.contains(playerName)
        
        return Player(name: playerName)
    }
}
