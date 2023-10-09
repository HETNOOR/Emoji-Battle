//
//  Player.swift
//  Emoji Battle
//
//  Created by Максим Герасимов on 02.10.2023.
//

import Foundation

class Player: Creature {
    var healingPotionsCount: Int = 4
    var bombsCount: Int = 2
    var fireballCooldown: Int = 0
    var moneyCount: Int = 0
    var fireballCooldowntUsed: Int = 4
    
    
    func useFireball() {
        if fireballCooldown == 0 {
            fireballCooldown = fireballCooldowntUsed
        }
    }
    
    func useBomb(target: Creature) {
        if bombsCount > 0 {
            // Генерируем случайный урон от 5 до 25
            let damage = Int.random(in: 5...25)
            
            target.takeDamage(damage, target: target)
            
            bombsCount -= 1
        }
    }
    
    func useHealingPotion() {
        if healingPotionsCount > 0 {
            // Логика для использования зелья лечения
            let healingAmount = Int(Double(healthMax) * 0.3)
            health += healingAmount
            if health > healthMax {
                health = healthMax
            }
           
            healingPotionsCount -= 1
        }
    }
    func fireballCooldownDecreases() {
        fireballCooldown -= 1
        if fireballCooldown - 1 < 0 {
            fireballCooldown = 0
        }
        
    }
    
}
