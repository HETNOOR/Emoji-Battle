//
//  ViewControllerStore.swift
//  Emoji Battle
//
//  Created by Максим Герасимов on 06.10.2023.
//

import UIKit
// Протокол для делегирования данных
protocol LavkaDelegate: AnyObject {
    func didPurchase(item: String, cost: Int)
    func didUpgradeAttack(damageIncrease: String, cost: Int)
}

class ViewControllerStore: UIViewController {

    weak var delegate: LavkaDelegate?
    var money: Int = 0
    var potions: Int = 0
    var bombs: Int = 0
    var attackDamage: Int = 10
    
    @IBOutlet var MoneyCount: UILabel!
    
    @IBOutlet var CloseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Принято значение money: \(money)")
        MoneyCount.text = "\(money)"
        CloseButton.layer.cornerRadius = CloseButton.frame.width/2
    }
    @IBAction func CloseButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    
    @IBAction func purchasePotionButtonTapped(_ sender: UIButton) {
        if money >= 10 {
            money -= 10
            potions += 1
            delegate?.didPurchase(item: "Potion", cost: 10)
            updateUI()
        }
        else {
            AlertNoMoney()
        }
           
       }

       @IBAction func purchaseBombButtonTapped(_ sender: UIButton) {
           if money >= 20 {
               money -= 20
               bombs += 1
               delegate?.didPurchase(item: "Bomb", cost: 20)
               updateUI()
           }
           else {
               AlertNoMoney()
           }
       }

       @IBAction func upgradeAttackButtonTapped(_ sender: UIButton) {
           if money >= 30 {
               money -= 30
               delegate?.didUpgradeAttack(damageIncrease: "Sword", cost: 30)
               updateUI()
           }
           else {
               AlertNoMoney()
           }
       }
    

    @IBAction func BuyUpgradeFireBall(_ sender: Any) {
        if money >= 40 {
            money -= 40
            delegate?.didUpgradeAttack(damageIncrease:  "FireBall", cost: 40)
            updateUI()
        }
        else {
            AlertNoMoney()
        }
    }
    
    func updateUI() {
        MoneyCount.text = "\(money)"
    }
    
    func AlertNoMoney() {
        
        let alert = UIAlertController(title: "Внимание", message: "Не хватает монет", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
    
}
