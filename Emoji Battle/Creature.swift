//
//  Creature.swift
//  Emoji Battle
//
//  Created by Максим Герасимов on 02.10.2023.
//

import Foundation

class Creature {
    var attack: Int
    var defense: Int
    var health: Int
    var healthMax: Int
    var damageRange: ClosedRange<Int>
    var diceCount: Int
    var damageNow: Int
    var upgrate: Int
    
    
    init(attack: Int, defense: Int, health: Int, damageRange: ClosedRange<Int>) {
        self.attack = attack
        self.defense = defense
        self.health = health
        self.healthMax = health
        self.damageRange = damageRange
        self.diceCount = 0
        self.damageNow = 0
        self.upgrate = 0
        
    }
    
    func attack(target: Creature)  -> Int {
        var damage = 0
        // Рассчитываем Модификатор атаки
        let attackModifier = max(attack - target.defense + 1, 1)
        
        // Бросок N кубиков
        let numberOfDice = attackModifier
        for _ in 1...numberOfDice {
            let diceRoll = Int.random(in: 1...6)
            diceCount = diceRoll
            if diceRoll >= 5 {
                damage = Int.random(in: damageRange)
                
                
                break
                
            }
        }
        print("damage: \(damage) attackModifier: \(attackModifier) diceRoll: \(diceCount) target: \(target)")
        return damage
    }
    
    func takeDamage(_ damage: Int, target: Creature) {
        target.health -= damage
        target.damageNow = damage
        if   target.health < 0 {
            target.health = 0
        }
    }
}
