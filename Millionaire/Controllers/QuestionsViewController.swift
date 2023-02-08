//
//  QuestionsViewController.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Лерочка on 05.02.2023.
//

import UIKit

class QuestionsViewController: UIViewController {
    var timer = Timer()
    var numOfQuestion = 0
    var status = ""
    var timeOff = 10
    var questionsArray: [UIImageView] = []
    var quiz = QuizBrain()
    var winMoney = ""
    var fireproofWin = "0"
    var audioPlayer = AudioPlayer()
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var buttonBackToGame: UIButton!
    
    @IBOutlet weak var firstQuestion: UIImageView!
    @IBOutlet weak var secondQuestion: UIImageView!
    
    @IBOutlet weak var thirdQuestion: UIImageView!
    
    @IBOutlet weak var fourthQuestion: UIImageView!
    
    @IBOutlet weak var fifthQuestion: UIImageView!
    
    @IBOutlet weak var sixthQuestion: UIImageView!
    
    @IBOutlet weak var seventhQuestion: UIImageView!
    
    @IBOutlet weak var eighthQuestion: UIImageView!
    
    @IBOutlet weak var ninthQuestion: UIImageView!
    
    @IBOutlet weak var tenthQuestion: UIImageView!
    
    @IBOutlet weak var eleventhQuestion: UIImageView!
    
    @IBOutlet weak var twelfthQuestion: UIImageView!
    
    @IBOutlet weak var thirteenthQuestion: UIImageView!
    
    @IBOutlet weak var fourteenthQuestion: UIImageView!
    
    @IBOutlet weak var fifteenthQuestion: UIImageView!
    
    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet weak var goGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("time", timeOff)
        buttonBackToGame.isHidden = true
        
        questionsArray = [ firstQuestion, secondQuestion, thirdQuestion, fourthQuestion, fifthQuestion, sixthQuestion, seventhQuestion, eighthQuestion, ninthQuestion, tenthQuestion, eleventhQuestion, twelfthQuestion, thirteenthQuestion, fourteenthQuestion, fifteenthQuestion ]
        
        print(status)
        
        for i in 0..<questionsArray.count {
            if numOfQuestion - 1 == i && status == "right" {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.winLabel.text = "Ваш выигрыш составляет \n\(self.winMoney) RUB"
                    }
                }
                questionsArray[i].image = UIImage(named: "RectangleGreen.png")
                // add sound + show button with basic text
                audioPlayer.playSound(soundName: "correctAnswer")
            }
            else if numOfQuestion - 1 == i && status == "wrong" {
                print("11", fireproofWin)
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.goGameButton.setTitle("Начать заново", for: .normal)
                        self.winLabel.text = "Ваш выигрыш составляет \n\(self.fireproofWin) RUB"
                    }
                }
                
                questionsArray[i].image = UIImage(named: "Rectangle red")
                // add sound + change button's title
                audioPlayer.playSound(soundName: "wrongAnswer")
            }
            else if numOfQuestion - 1 == 4 || numOfQuestion - 1 == 9 {
                fireproofWin = winMoney
                print("11", fireproofWin)
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.winLabel.text = "Ваш выигрыш составляет \n\(self.winMoney) RUB"
                    }
                }
                audioPlayer.playSound(soundName: "correctAnswer")
            }
            else if numOfQuestion - 1 == 14 {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.goGameButton.setTitle("Начать заново", for: .normal)
                        self.winLabel.text = "Вы победили! \nВаш выигрыш составляет \n\(self.winMoney)"
                    }
                }
                audioPlayer.playSound(soundName: "correctAnswer")
            } else if timeOff == 0 {
                audioPlayer.playSound(soundName: "wrongAnswer")
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.goGameButton.setTitle("Начать заново", for: .normal)
                        self.winLabel.text = "Ваш выигрыш составляет \n\(self.fireproofWin)"
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameViewController {
            let gameVC = segue.destination as? GameViewController
            if goGameButton.currentTitle == "Продолжить игру" {
                gameVC?.num  = numOfQuestion
                print("num vc",gameVC?.num)
            } else {
                gameVC?.num = 0
                
            }
            
        }
    }
    
    
    @IBAction func backToGamePressed(_ sender: UIButton) {
        
    }
    
}
