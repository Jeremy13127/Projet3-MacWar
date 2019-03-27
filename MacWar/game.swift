//
//  game.swift
//  MacWar
//
//  Created by Jeremy Juan on 26/02/2019.
//  Copyright © 2019 Jeremy Juan. All rights reserved.
//

import Foundation
import Darwin

class Game {
    
    // MARK: - Properties
    
    private static let maxPlayerCount = 2
    private static let maxCharacterCount = 3
    
    private var players: [Player] = []
    private var playerNames: [String] = []
    private var characterNames: [String] = []
    private var counterPlay = 0
    
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
        print("")
        print("////////////////////////////////////////////////////////////////")
        print("////////////////////////////////////////////////////////////////")
        if counterPlay == 0 {
            print("           La partie commence... A vos postes soldats!           ")
        } else {
            print("           La partie recommence... A vos postes soldats!           ")
            print("\(players[0].name) : \(players[0].score) - \(players[1].name) : \(players[1].score)")
        }
        
        var counter = 0
        var characterAttack: Character
        var characterCare: Character
        var characterDefend: Character
        var lastAttacker: Player
        var lastDefender: Player
        
        repeat {
            guard let attacker = players.first, let defender = players.last else {
                fatalError("We should have 2 players at this time")
            }
            print("")
            print("C'est à \(attacker.name) de jouer")
            statisticsPlayers()
            
            repeat {
                let index = chooseCharacterIndex(who: 0)
                characterAttack = chooseCharacter(at: index, from: attacker.characters)
            } while !characterAttack.isAlive
            
            let bonus = randomBonus()
            
            if characterAttack.type == .magus && characterAttack.life > 0  {
                repeat {
                    let index = chooseCharacterIndex(who: 1)
                    characterCare = chooseCharacter(at: index, from: attacker.characters)
                } while !characterCare.isAlive && characterCare.type == .magus
                characterCare.updateLife(with: characterAttack.weapon.action, characterType: characterCare.type, bonus: bonus)
                print("\(characterAttack.name) soigne \(characterCare.name) qui possède désormais \(characterCare.life)")
            } else {
                repeat {
                    let index = chooseCharacterIndex(who: 2)
                    characterDefend = chooseCharacter(at: index, from: defender.characters)
                } while !characterDefend.isAlive
                characterDefend.updateLife(with: characterAttack.weapon.action, characterType: characterDefend.type, bonus: bonus)
                print("\(characterAttack.name) attaque \(characterDefend.name) qui possède désormais \(characterDefend.life)")
            }
            
            counter += 1
            lastAttacker = attacker
            lastDefender = defender
            players.swapAt(0, 1)
        } while findAliveCharacter(in: lastDefender.characters)
        
        launchEndGame(with: lastAttacker, and: lastDefender)
    }
    
    private func launchEndGame(with attacker: Player, and defender: Player) {
        var _userChoice = ""
        var again = true
        var choiceCounter = 0
        
        congrats(for: attacker, and: defender)
        statisticsPlayers()
        repeat {
            print("Vous souhaitez : ")
            print("Recommencer une partie ? Tapez 1")
            print("Créer une nouvelle partie ? Tapez 2")
            print("Quitter le jeu ? Tapez 3")
            if choiceCounter == 0 {
                print("Votre choix :")
            } else {
                print("ERREUR ### Merci de choisir une option valide")
            }
            if let readChoice = readLine(){
                _userChoice = readChoice
            }
            switch _userChoice {
            case "1":
                restart()
            case "2":
                newGame()
            case "3":
                print("On quitte le jeu")
                exit(0)
            default:
                again = false
            }
            choiceCounter += 1
        } while again == false
    }
    
    // MARK: - Helpers
    
    private func createPlayer(for index: Int) -> Player {
        var playerNameCounter = 0
        var playerName: String
        repeat {
            print("")
            print("////////////////////////////////////////////////////////////////")
            print("////////////////////////////////////////////////////////////////")
            print("                   CREATION DU JOUEUR \(index)                   ")
            if playerNameCounter == 0 {
                print("Choisissez un nom de joueur :")
            } else {
                print("ERREUR ### Merci d'entrer un nom valide")
            }
            if let _playerName = readLine() {
                playerName = _playerName
            } else {
                playerName = ""
            }
            playerNameCounter += 1
        } while playerName == "" || playerNames.contains(playerName)
        playerNames.append(playerName)
        return Player(name: playerName)
    }
    
    private func createCharacters() -> [Character] {
        var characters: [Character] = []
        print("                   CREATION DES PERSONNAGES                      ")
        for index in 0..<Game.maxCharacterCount {
            let character = createCharacter(for: index)
            characters.append(character)
        }
        return characters
    }
    
    private func createCharacter(for index: Int) -> Character {
        var characterNameCounter = 0
        var characterName = ""
        var _typeInput = ""
        var characterType: CharacterType?
        
        repeat {
            if characterNameCounter == 0 {
                print("Choisissez un nom de personnage \(index) :")
            } else {
                print("ERREUR ### Merci d'entrer un nom ou type valide")
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
        } while characterType == nil || characterName == "" || characterNames.contains(characterName)
        characterNames.append(characterName)
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
    
    private func chooseCharacterIndex(who character: Int) -> Int {
        var _index = ""
        var index: Int
        var characterIdCounter = 0
        repeat {
            if characterIdCounter == 0 && character == 0 {
                print("Choisissez l'id de votre personnage pour attaquer :")
            } else if characterIdCounter == 0 && character == 1 {
                print("Choisissez l'id de votre personnage à soigner :")
            } else if characterIdCounter == 0 && character == 2 {
                print("Choisissez l'id du personnage à attaquer :")
            } else {
                print("ERREUR ### Merci d'entrer un id valide")
            }
            
            if let Choice = readLine(){
                _index = Choice
            }
            switch _index {
            case "0":
                index = 0
            case "1":
                index = 1
            case "2":
                index = 2
            default:
                index = 3
            }
            characterIdCounter += 1
        } while index == 3
        return index
    }
    
    private func chooseCharacter(at index: Int, from characters: [Character]) -> Character {
        guard index < characters.count else {
            fatalError("Index out of range")
        }
        return characters[index]
    }
    
    private func findAliveCharacter(in characters: [Character]) -> Bool {
        return characters.contains(where: { charater in
            return charater.type != .magus && charater.life > 0
        })
    }
    
    private func congrats(for playerWin: Player, and playerLose: Player) {
        print("")
        print("")
        print("////////////////////////////////////////////////////////////////")
        print("////////////////////////////////////////////////////////////////")
        print("La partie est terminée!")
        print("Félicitation à \(playerWin.name)! Quelle magnifique victoire!!")
        playerWin.score += 1
        print("\(playerWin.name) : \(playerWin.score) - \(playerLose.name) : \(playerLose.score)")
    }
    
    private func restart() {
        players.forEach { (player) in
            for character in player.characters {
                switch character.type {
                case .warrior:
                    character.life = 100
                case .magus:
                    character.life = 25
                case .colossus:
                    character.life = 50
                case .dwarf:
                    character.life = 30
                }
            }
        }
        counterPlay += 1
        play()
    }
    
    private func newGame() {
        players.removeAll()
        playerNames.removeAll()
        characterNames.removeAll()
        settings()
    }
    
    private func randomBonus() -> Int {
        // INTEGRER BONUS QUI DOUBLE LES POINTS D'ATTAQUE-GUERISON OU BIEN DIVISE PAR 2 CES MEMES POINTS
        let bonus = Int.random(in: 0..<5)
        if bonus == 0 {
            print("Les Points d'attaque ou de guérison sont doublés!!")
        } else if bonus == 1{
            print("Les Points d'attaque ou de guérison sont divisés par 2!!")
        }
        return bonus
    }
    
}
