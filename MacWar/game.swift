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
    // var addPlayer: Player
    
    
    // MARK: - Game logic
    
    func start() {
        setting()
    }
    
    func setting() {
        
        print("Bonjour est bienvenue sur MacWar!")

        for playerIndex in 1..<3 { // Boucle x2 joueurs dans la partie

            // Création du joueur de la partie
            let player = createPlayer(for: playerIndex)

            // Création des personnages de la partie
            for playerIndex in 1..<4 { // Boucle x2 joueurs dans la partie
                var addPlayer = createCharacter(player: player, playerIndex: playerIndex)
            }
            
            // Ajout du joueur ainsi que de ses personnages
            players.append(addPlayer)
            
        }
        
        // Récapitulatif des équipes
        statisticsPlayers()
    
        play()
    }
    
    func play() {
        
        print("La partie commence... Préparez votre armée MacWar!")
        
        // Boucle while tant que le joueur à au moins un personnage
        
        // Fonction attaque(joueur1, arme, joueur2)
        
        // Fonction qui vérifie si un des deux joueurs n'a plus de personnage
        
        end()
    }
    
    func end() {
        // Afficher le recap
        statisticsPlayers()
        
        // Fonction qui félicite le vainqueur et qui propose de recommencer une partie ou pas
        
        print("Le jeu est terminé!")
    }

    
    
    // MARK: - Functions

    // Fonction qui permet de créer un Joueur
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
                playerName = _playerName
                print("vous avez choisi comme nom de joueur: \(playerName)")
                playerNames.append(playerName)
            } else {
                playerName = ""
            }
            
            playerNameCounter += 1
        } while playerName == "" && !playerNames.contains(playerName)
        
        return Player(name: playerName)
    }
    
    
    // Fonction qui permet de créer les personnages du joueur
    private func createCharacter(player: Player, playerIndex: Int) -> Player {
        var characterNameCounter = 0
        var characterName: String = ""
        var characterType: String = ""
        var type: CharacterType?
        
        repeat {
            if characterNameCounter == 0 {
                // Création des personnages de la partie
                print("Choisissez un nom de personnage \(playerIndex):")
            } else {
                print("Merci d'entrer un nom de personnage non présent dans la partie")
            }
            
            if let _characterName = readLine() {
                characterName = _characterName
                // print("vous avez choisi comme nom de personnage: \(characterName)")
                
                repeat {
                    // Choix du type du personnage
                    print("Choisissez le type du personnage \(characterName):")
                    print("1 - Warrior")
                    print("2 - Magus")
                    print("3 - Colossus")
                    print("4 - Dwarf")
                    
                    guard let choice = readLine() else { return }
                    
                    type = CharacterType(choice: choice)
                    
                } while type == nil
                
                if let type = type {
                    characterType = type
                }
                
            } else {
                characterName = ""
            }
            
            characterNameCounter += 1
        } while characterName == ""
        
        let character1 = Character(type: characterType, name: characterName)
        player.addCharacter(character: character1)
        
        return player
    }
    
    
    // Fonction qui permet d'afficher les statistiques des joueurs
    private func statisticsPlayers() {
        players.forEach { (player) in
            // Affichage du nom du joueur
            print("Récapitulatif de l'équipe de \(player.name) ")
            for character in player.characters {
                print(character.name)
                if character.score == 0 {
                    print("\(character.name) possède \(character.score) point de vie")
                }
                else{
                    print("\(character.name) possède \(character.score) points de vie")
                }
            }
        }
    }
    
}
