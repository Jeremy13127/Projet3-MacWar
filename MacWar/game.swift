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
    
    private static let maxPlayerCount = 2
    private static let maxCharacterCount = 3
    
    private var players: [Player] = []
    private var playerNames: [String] = []
    
    // MARK: - Start
    
    /// Start the game.
    func start() {
        settings()
    }
    
    // MARK: - Game logic
    
    /// This function handle the configuration for the players and their characters.
    private func settings() {
        print("Bonjour est bienvenue sur MacWar!")
        for playerIndex in 0..<Game.maxPlayerCount {
            let player = createPlayer(for: playerIndex)
            player.initializeCharacters(characters: createCharacters())
            players.append(player)
        }
        play()
    }
    
    
    private func play() {
        print("////////////////////////////////////////////////////////////////")
        print("////////////////////////////////////////////////////////////////")
        print("           La partie commence... A vos postes soldats!           ")
        
        guard let attacker = players.first, let defender = players.last else {
            fatalError("We should have 2 players at this time")
        }
        
        var counter = 0
        var characterAttack: Character
        var characterDefend: Character
        
        repeat {
            print("")
            print("C'est à \(attacker.name) de jouer")
            statisticsPlayers()
            characterAttack = attacker.characters[attackerChoice()]
            characterDefend = defender.characters[defenderChoice()]
            characterDefend.updateLife(with: characterAttack.weapon.action)
            print("\(characterAttack.name) attaque \(characterDefend.name) qui possède désormais \(characterDefend.life)")
            print("\(players[0].name) - \(players[1].name)")
            players.swapAt(0, 1)
            print("\(players[0].name) - \(players[1].name)")
            counter += 1
        } while counter < 10
            // while true /// Tant que pour chacun des 2  joueurs, ils ont au moins un chracter avec une vie > 0 && ce ne sont pas tous les 2 des mages -> egalité.
        
        end()
    }
    
    private func end() {
        statisticsPlayers()
        print("Le jeu est terminé!")
    }
    
    // MARK: - Helpers
    
    private func createPlayer(for index: Int) -> Player {
        var playerNameCounter = 0
        var playerName: String = ""
        repeat {
            print("////////////////////////////////////////////////////////////////")
            print("////////////////////////////////////////////////////////////////")
            print("                   CREATION DU JOUEUR \(index)                   ")
            if playerNameCounter == 0 {
                print("Choisissez un nom de joueur :")
            } else {
                print("Merci d'entrer un nom valide")
            }
            
            if let _playerName = readLine() {
                playerName = _playerName
                playerNames.append(playerName)
            } else {
                playerName = ""
            }
            
            playerNameCounter += 1
        } while playerName == "" && !playerNames.contains(playerName)
        
        return Player(name: playerName)
    }
    
    private func createCharacters() -> [Character] {
        var characters: [Character] = []
        print("                   CREATION DES PERSONNAGES                      ")
        for _ in 0..<Game.maxCharacterCount {
            let character = createCharacter()
            characters.append(character)
        }
        return characters
    }
    
    private func createCharacter() -> Character {
        var characterNameCounter = 0
        var characterName = ""
        var _typeInput = ""
        var characterType: CharacterType?
        
        repeat {
            if characterNameCounter == 0 {
                print("Choisissez un nom de personnage :")
            } else {
                print("Merci d'entrer un nom ou type valide")
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
                
            } else {
                characterName = ""
            }
            
            characterNameCounter += 1
        } while characterType == nil && characterName == "" && !playerNames.contains(characterName)
        
        return Character(name: characterName, type: characterType!)
    }
    
    private func statisticsPlayers() {
        players.forEach { (player) in
            print("////////////////////////////////////////////////////////////////")
            print("Récapitulatif de l'équipe de \(player.name) :")
            var counter = 0
            for character in player.characters {
                if character.life == 0 {
                    print("\(counter) - \(character.name) ne fait plus partie du jeu")
                } else if character.life == 1{
                    print("\(counter) - \(character.name) de type \(character.type) possède \(character.life) point de vie")
                } else{
                    print("\(counter) - \(character.name) de type \(character.type) possède \(character.life) points de vie")
                }
                counter += 1
            }
        }
        print("////////////////////////////////////////////////////////////////")
    }
    
    private func attackerChoice() -> Int {
        var _indexAttacker = ""
        var indexAttacker: Int
        repeat {
            print("Choisissez l'id de votre personnage pour attaquer :")
            if let attackerChoice = readLine(){
                _indexAttacker = attackerChoice
            }
            switch _indexAttacker {
            case "0":
                indexAttacker = 0
            case "1":
                indexAttacker = 1
            case "2":
                indexAttacker = 2
            default:
                indexAttacker = 3
            }
        } while indexAttacker == 3
        return indexAttacker
    }
    
    private func defenderChoice() -> Int {
        var _indexDefender = ""
        var indexDefender: Int
        repeat {
            print("Choisissez l'id du personnage à attaquer :")
            if let defenderChoice = readLine(){
                _indexDefender = defenderChoice
            }
            switch _indexDefender {
            case "0":
                indexDefender = 0
            case "1":
                indexDefender = 1
            case "2":
                indexDefender = 2
            default:
                indexDefender = 3
            }
        } while indexDefender == 3
        return indexDefender
    }
    
    private func checkLife(characters : [Character]) -> Int {
        var life = 0
        life = characters.count
        return life
    }
}
