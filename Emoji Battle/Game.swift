//
//  Game.swift
//  Emoji Battle
//
//  Created by Максим Герасимов on 02.10.2023.
//

import Foundation

class Game {
    var player: Player
    var monster: Monster
    
    init() {
        player = Player(attack: 10, defense: 5, health: 50, damageRange: 4...10)
        monster = Monster(attack: 8, defense: 4, health: 30, damageRange: 2...8)
    }
    
    func playerTurn() {
        
        player.attack(target: monster)
        
    }
    
    func monsterTurn() {
        monster.attack(target: player)
    
    }
    
    func isGameOver() -> Bool {
           return player.health <= 0 || monster.health <= 0
    }
    
    func createNewMonster() {
            monster = Monster(attack: 8, defense: 4, health: 40, damageRange: 2...8)
        }
    
    func restartGame() {
           // Создаем нового игрока и нового монстра с начальными параметрами
           player = Player(attack: 10, defense: 5, health: 50, damageRange: 1...6)
           monster = Monster(attack: 8, defense: 4, health: 50, damageRange: 2...8)
       }
    // Дополнительные методы для управления игрой, если необходимо
}
