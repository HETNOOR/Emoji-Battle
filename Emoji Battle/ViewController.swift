//
//  ViewController.swift
//  Emoji Battle
//
//  Created by Максим Герасимов on 28.09.2023.
//

import UIKit
import CoreGraphics
import Foundation

class ViewController: UIViewController, LavkaDelegate {
    
    
    
    
    // MARK: - Outlets
    @IBOutlet var Menuview: UIView!
    
    @IBOutlet var PlayerEmojiLabel: UILabel!
    @IBOutlet var MonsterEmojiLabel: UILabel!
    
    @IBOutlet var RollDiceButton: UIButton!
    
    @IBOutlet var DiceView: UIView!
    @IBOutlet var Money: UILabel!
    
    @IBOutlet var BubbleBombCount: UIView!
    @IBOutlet var BubbleHealingPotionCount: UIView!
    @IBOutlet var BombCount: UILabel!
    @IBOutlet var HealingPotionCount: UILabel!
    
    @IBOutlet var DamageMoster: UILabel!
    @IBOutlet var DamagePlayer: UILabel!
    
    @IBOutlet var PlayerDefen: UILabel!
    @IBOutlet var PlayerDamageRenge: UILabel!
    
    
    @IBOutlet var MonsterDamageRenge: UILabel!
    @IBOutlet var MonsterDefense: UILabel!
    
    
    @IBOutlet var DiceAnimate: UILabel!
    @IBOutlet var ResultLabel: UILabel!
    @IBOutlet var DiceCount: UILabel!
    
    @IBOutlet var HealthBarBackground: UIView!
    @IBOutlet var HealthBar: UIView!
    @IBOutlet var HealthBarBackgroundMonser: UIView!
    @IBOutlet var HealthBarMonster: UIView!
    
    @IBOutlet var HealthCountMonster: UILabel!
    @IBOutlet var HealthCountPlayer: UILabel!
    
    
    // MARK: - Properties
    var originalFrame: CGRect!
    var game: Game!
    
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        
    }
    
    // MARK: - Actions
    
    @IBAction func rollDiceButtonTapped(_ sender: UIButton) {
        // Игрок бросает кубик и выполняет анимацию атаки
        RollDiceButton.isEnabled = false
        playerTurn()
       
    }
    
    @IBAction func UseHealingPotionButton(_ sender: UIButton) {
        game.player.useHealingPotion()
        
        updateUI()
        
    }
    
    @IBAction func UseBombButton(_ sender: Any) {
        game.player.useBomb(target: game.monster)
        updateUI()
        if game.isGameOver() {endGame()}
    }
    
    
    // MARK: - CreatureTurn Methods
    
    func playerTurn() {
        game.playerTurn()
        animatePlayerAttack()
        rollDice(game.player.diceCount) {
            // Завершение анимации игрока
            if self.game.isGameOver() {
                self.endGame()
            } else {
                // Передача хода монстру через задержку
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [self] in
                    self.monsterTurn()
                    DamageMoster.isHidden = true
                }
            }
        }
    }
    
    func monsterTurn() {
        // Анимация атаки монстра
        // Ход монстра
        game.monsterTurn()
        animateMonsterAttack()
        rollDice(game.monster.diceCount) {
            // Завершение анимации монстра
            if self.game.isGameOver() {
                self.endGame()
            } else {
                // Обновление UI после хода монстра
                self.updateUI()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.RollDiceButton.isEnabled = true
                    self.DamagePlayer.isHidden = true
                    
                }
                
            }
        }
        
    }
    

    // MARK: - Helper Methods
    
    func updateUI() {
        // Обновление здоровья игрока и монстра на экране
        Money.text = "\(game.player.moneyCount)"
        
        HealthCountPlayer.text = " \(game.player.health)"
        HealthCountMonster.text = " \(game.monster.health)"
        
        HealthBar.frame.size.width = (CGFloat(game.player.health) / CGFloat(game.player.healthMax)) * HealthBarBackground.frame.width
        
        HealthBarMonster.frame.size.width = (CGFloat(game.monster.health) / CGFloat(game.monster.healthMax)) * HealthBarBackgroundMonser.frame.width
        
        HealingPotionCount.text = "\(game.player.healingPotionsCount)"
        BombCount.text = "\(game.player.bombsCount)"
        
    }
    
    func setupUI() {
        game = Game()
        PlayerDamageRenge.text = "\(game.player.damageRange)"
        PlayerDefen.text = "\(game.player.defense)"
        MonsterDamageRenge.text = "\(game.monster.damageRange)"
        MonsterDefense.text = "\(game.monster.defense)"
        originalFrame = PlayerEmojiLabel.frame
        Menuview.layer.shadowOffset = CGSizeMake(0, -15)
        Menuview.layer.shadowOpacity = 1
        Menuview.layer.shadowRadius = 15
        Menuview.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        
        BubbleBombCount.layer.cornerRadius = BubbleBombCount.frame.width/2
        BubbleHealingPotionCount.layer.cornerRadius = BubbleHealingPotionCount.frame.width/2
        
        
        HealthBarBackground.layer.cornerRadius = 10
        HealthBar.layer.cornerRadius = 10
        HealthBarBackgroundMonser.layer.cornerRadius = 10
        HealthBarMonster.layer.cornerRadius = 10

    }
    
    func endGame() {
        if game.player.health <= 0 {
            // Игрок проиграл
            let alertController = UIAlertController(title: "Вы проиграли", message: "Начать игру заново?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Да", style: .default) { (_) in
                // Начать игру заново
                self.DamagePlayer.isHidden = true
                self.RollDiceButton.isEnabled = true
                self.game.restartGame()
                self.updateUI()
            }
            alertController.addAction(restartAction)
            present(alertController, animated: true, completion: nil)
        } else {
            
            // Игра не окончена ничьей, и игрок не проиграл
            let reward = Int.random(in: 50...100)
            let alertController = UIAlertController(title: "Игра завершена", message: "Получено \(reward) монет!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Продолжить", style: .default) { (_) in
                // Создаем нового монстра и обновляем интерфейс
                self.game.player.moneyCount += reward
                self.game.createNewMonster()
                self.updateUI()
                self.DamageMoster.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.RollDiceButton.isEnabled = true
                    
                }
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
 
    
    // MARK: - Animation Methods
    func animateCharacterAttack(_ characterLabel: UILabel, damage: Int, damageLabel: UILabel, enemyLabel: UILabel, isPlayer: Bool) {
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        let newXPosition = characterLabel.frame.origin.x + (isPlayer ? 100 : -100) // Сдвигаем на 100 пикселей вправо для игрока и влево для монстра

        let newFrame = CGRect(x: newXPosition,
                              y: characterLabel.frame.origin.y,
                              width: characterLabel.frame.size.width,
                              height: characterLabel.frame.size.height)

        UIView.animate(withDuration: 0.2, animations: {
            characterLabel.frame = newFrame
        }) { (completed) in
            UIView.animate(withDuration: 0.1, animations: {
                enemyLabel.frame.origin.x -= (isPlayer ? -20 : 20) // Сдвигаем текст влево для игрока и вправо для монстра
            }) { (completed) in
                if damage >= 5 {
                    damageLabel.isHidden = false
                    damageLabel.text = "-\(damage)"
                } else {
                    damageLabel.isHidden = false
                    damageLabel.text = "промах"
                }
                UIView.animate(withDuration: 0.5, animations: {
                    enemyLabel.frame.origin.x += (isPlayer ? -20 : 20)
                    characterLabel.frame.origin.x += (isPlayer ? -100 : 100)
                    
                }) { (completed) in
                    impactFeedbackGenerator.impactOccurred()
                    print("*Вибрация*")
                    if self.game.isGameOver() {
                        self.endGame()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            
                            damageLabel.isHidden = true
                        }
                    }
                }
            }
        }
    }

    func animatePlayerAttack() {
        animateCharacterAttack(PlayerEmojiLabel, damage: game.monster.damageNow, damageLabel: DamageMoster, enemyLabel: MonsterEmojiLabel, isPlayer: true)
    }

    func animateMonsterAttack() {
        animateCharacterAttack(MonsterEmojiLabel, damage: game.player.damageNow, damageLabel: DamagePlayer, enemyLabel: PlayerEmojiLabel, isPlayer: false)
    }

    
    
    // MARK: - rollDice Methods
    
    func rollDice(_ diceRoll: Int, completion: @escaping () -> Void) {
        
        DiceView.isHidden = false
        // Сначала настраиваем начальное состояние элементов до анимации
        DiceAnimate.alpha = 0.0 // Начальная прозрачность DiceLabel
        ResultLabel.alpha = 0.0 // Начальная прозрачность ResultLabel
        DiceCount.alpha = 0.0
        
        UIView.animate(withDuration: 0.2, animations: {
            // Анимация появления кубика
            self.DiceAnimate.alpha = 1.0 // Устанавливаем прозрачность на 1.0 (появление)
        }) { (completed) in
            // По окончании анимации появления DiceLabel
            // Выполняем анимацию вращения кубика
            UIView.animate(withDuration: 0.3, animations: {
                self.DiceAnimate.transform = CGAffineTransform(rotationAngle: .pi ) // Вращение на 180 градусов
                
            }) { (completed) in
                
                // По окончании анимации вращения DiceLabel
                // Выполняем анимацию скрытия DiceLabel и появления ResultLabel
                UIView.animate(withDuration: 0.2, animations: {
                    self.DiceAnimate.transform = CGAffineTransform(rotationAngle: .pi*2 ) // Вращение на 180
                    self.DiceAnimate.alpha = 0.0 // Устанавливаем прозрачность на 0.0 (скрытие)
                    
                    self.DiceCount.alpha = 1.0 // Устанавливаем прозрачность ResultLabel на 1.0 (появление)
                    
                    self.DiceCount.text =  "\(diceRoll)"
                }) { (completed) in
                    self.updateUI()
                    self.ResultLabel.alpha = 1.0 // Устанавливаем прозрачность ResultLabel на 1.0 (появление)
                    self.ResultLabel.text = (diceRoll >= 5) ? "УСПЕХ" : "ПРОВАЛ"
                    completion()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.DiceView.isHidden = true
                    }
                    
                }
            }
        }
    }
    
    
    // MARK: - segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLavkaSegue", let lavkaVC = segue.destination as? ViewControllerStore {
            lavkaVC.delegate = self
            lavkaVC.money = game.player.moneyCount
            print("Передано значение money: \(game.player.moneyCount)")
        }
    }
    
    
    
    // Реализация методов делегата
    func didPurchase(item: String, cost: Int) {
        game.player.moneyCount -= cost
        print("Куплен товар: \(item), стоимость: \(cost)")
        if item == "Potion" {
            game.player.healingPotionsCount += 1
        }
        else if item == "Bomb" {
            game.player.bombsCount += 1
        }
        updateUI()
    }
    
    func didUpgradeAttack(damageIncrease: Int, cost: Int) {
        game.player.moneyCount -= cost
        game.player.upgrate += 1
        PlayerDamageRenge.text = "\(game.player.damageRange) +\(game.player.upgrate)"
        print("Улучшение атаки +\(damageIncrease), стоимость: \(cost)")
        updateUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

