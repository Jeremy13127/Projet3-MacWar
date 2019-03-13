//
//  game.swift
//  MacWar
//
//  Created by Jeremy Juan on 26/02/2019.
//  Copyright © 2019 Jeremy Juan. All rights reserved.
//

import Foundation

import Foundation

class Game {
    
    // MARK: - Properties
    
    private static let maxPlayerCount = 2
    private static let maxCharacterCount = 3
    
    var players: [Player] = []
    var playerNames: [String] = []
    
    // MARK: - Game logic
    
    func start() {
        setting()
    }
    
    func setting() {
        
        print("Bonjour est bienvenue sur MacWar!")
        
        for playerIndex in 0..<Game.maxPlayerCount { // Boucle x2 joueurs dans la partie
            
            // Création du joueur de la partie
            let player = createPlayer(for: playerIndex)
            player.initializeCharacters(characters: createCharacters())
            
            // Ajout du joueur ainsi que de ses personnages
            players.append(player)
        }
        
        // Récapitulatif des équipes
        statisticsPlayers()
        
        play()
    }
    
    func play() {
        
        print("La partie commence... A vos postes soldats!")
        
        /*
         // Boucle while tant que le joueur à au moins un personnage
         repeat {
         
         // On affiche les états de chacun des personnages
         statisticsPlayers()
         
         // Fonction attaque(joueur1, arme, joueur2)
         
         // Fonction qui vérifie si un des deux joueurs n'a plus de personnage
         end()
         
         } while true
         */
        
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
    private func createCharacters() -> [Character] {
        var characters: [Character] = []
        
        for _ in 0..<Game.maxCharacterCount { // Boucle x2 joueurs dans la partie
            let character = createCharacter()
            characters.append(character)
        }
        
        return characters
    }
    
    private func createCharacter() -> Character {
        var characterName = ""
        var characterType: CharacterType?
        
        repeat {
            // Code pour récupérer entrée utilisateur pour le choix du nom + choix du type
            if let stringInput = readLine() {
                characterName = stringInput
            } else {
                characterName = ""
            }
        } while characterType == nil && characterName == "" && !playerNames.contains(characterName)
        
        return Character(name: "Toto", type: characterType!)
    }
    
    
    // Fonction qui permet d'afficher les statistiques des joueurs
    private func statisticsPlayers() {
        players.forEach { (player) in
            // Affichage du nom du joueur
            print("Récapitulatif de l'équipe de \(player.name) ")
            for character in player.characters {
                print(character.name)
                if character.life == 0 {
                    print("\(character.name) ne fait plus partie du jeu")
                }
                else if character.life == 1{
                    print("\(character.name) possède \(character.life) point de vie")
                }
                else{
                    print("\(character.name) possède \(character.life) points de vie")
                }
            }
        }
    }
    
}
