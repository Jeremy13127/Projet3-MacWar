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
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet de créer les joueurs, les personnages et de lancer la partie
    func setting() {
        
        print("Bonjour est bienvenue sur MacWar!")
        
        for playerIndex in 0..<Game.maxPlayerCount { // Boucle x2 joueurs dans la partie
            
            // Création du joueur de la partie
            let player = createPlayer(for: playerIndex)
            player.initializeCharacters(characters: createCharacters())
            
            // Ajout du joueur ainsi que de ses personnages
            players.append(player)
        }
        
        play()
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet de lancer la partie combat
    func play() {
        
        print("La partie commence... A vos postes soldats!")
        
         // Boucle while tant que le joueur à au moins un personnage
         repeat {
         
         // On affiche les états de chacun des personnages
         statisticsPlayers()
         
         // Fonction attaque(joueur1, arme, joueur2)
         
            
         } while checkLife(idEnnemy: <#T##Int#>)
     
        end()
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet de terminer le jeu
    func end() {
        // Afficher le recap
        statisticsPlayers()
        
        // Fonction qui félicite le vainqueur et qui propose de recommencer une partie ou pas
        
        
        print("Le jeu est terminé!")
    }
    
    
    
    // MARK: - Functions
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet de créer un Joueur
    private func createPlayer(for index: Int) -> Player {
        var playerNameCounter = 0
        var playerName: String = ""
        repeat {
            print("////////////////////////////////////////////////////////////////")
            print("////////////////////////////////////////////////////////////////")
            print("                   CREATION DU JOUEUR \(index)                   ")
            if playerNameCounter == 0 {
                // Création des personnages de la partie
                print("Choisissez un nom de joueur :")
            } else {
                print("Merci d'entrer un nom valide")
            }
            
            if let _playerName = readLine() {
                playerName = _playerName
                // print("vous avez choisi comme nom de joueur: \(playerName)")
                playerNames.append(playerName)
            } else {
                playerName = ""
            }
            
            playerNameCounter += 1
        } while playerName == "" && !playerNames.contains(playerName)
        
        return Player(name: playerName)
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet de créer les personnages du joueur
    private func createCharacters() -> [Character] {
        var characters: [Character] = []
        
        print("                   CREATION DES PERSONNAGES                      ")
        for _ in 0..<Game.maxCharacterCount { // Boucle x3 joueurs dans la partie
            let character = createCharacter()
            characters.append(character)
        }
        
        return characters
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet de créer un personnage
    private func createCharacter() -> Character {
        var characterNameCounter = 0
        var characterName = ""
        var _typeInput = ""
        var characterType: CharacterType?
        
        repeat {
            // Code pour récupérer entrée utilisateur pour le choix du nom + choix du type
            if characterNameCounter == 0 {
                // Création des personnages de la partie
                print("Choisissez un nom de personnage :")
            } else {
                print("Merci d'entrer un nom valide")
            }
            
            if let nameInput = readLine() {
                characterName = nameInput
                
                print("Choisissez le type du personnage \(characterName) :")
                print("1 - Un guerrier")
                print("2 - Un mage")
                print("3 - Un colosse")
                print("4 - Un nain")
                print("Votre choix :")
                
                if let choice = readLine(){
                    _typeInput = choice
                }
                
                characterType = CharacterType(choice: _typeInput)
                
                // characterType = .warrior
            } else {
                characterName = ""
            }
                
            characterNameCounter += 1
        } while characterType == nil && characterName == "" && !playerNames.contains(characterName)
        
        return Character(name: characterName, type: characterType!)
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet d'afficher les statistiques des joueurs
    private func statisticsPlayers() {
        players.forEach { (player) in
            print("////////////////////////////////////////////////////////////////")
            print("////////////////////////////////////////////////////////////////")
            // Affichage du nom du joueur
            print("Récapitulatif de l'équipe de \(player.name) :")
            for character in player.characters {
                if character.life == 0 {
                    print("\(character.name) ne fait plus partie du jeu")
                }
                else if character.life == 1{
                    print("\(character.name) de type \(character.type) possède \(character.life) point de vie")
                }
                else{
                    print("\(character.name) de type \(character.type) possède \(character.life) points de vie")
                }
            }
        }
        print("////////////////////////////////////////////////////////////////")
        print("////////////////////////////////////////////////////////////////")
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // Fonction qui permet de créer les personnages du joueur
    private func checkLife(idEnnemy : Int) -> Bool {
        
        let nbrCharacter = players[idEnnemy].tableOfCharacterCount()
        
        // On vérifie si le joueur adverse possède encore au moins un personnage
        if nbrCharacter != 0 {
            return true
        }
        else{
            return false
        }
    }
    
}
