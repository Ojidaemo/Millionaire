//
//  QuestionsViewController.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Лерочка on 05.02.2023.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    var numOfQuestion = 0
    var status = ""
    var timeOff = 10
    var winMoney = ""
    var fireproofWin = "0"
    var timer = Timer()
    var quiz = QuizBrain()
    var audioPlayer = AudioPlayer()
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet var questionsArray: [UIImageView]!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var goGameButton: UIButton!
    
    // stop music from playing
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioPlayer.player?.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func updateUI() {
        
        for i in 0..<questionsArray.count {
            if numOfQuestion - 1 == i && status == "right" {
                questionsArray[i].image = UIImage(named: "RectangleGreen.png")
                audioPlayer.playSound(soundName: "correctAnswer")
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.winLabel.text = "Ваш выигрыш составляет \n\(self.winMoney) RUB"
                    }
                }
            }
            else if numOfQuestion - 1 == i && status == "wrong" {
                questionsArray[i].image = UIImage(named: "Rectangle red")
                audioPlayer.playSound(soundName: "wrongAnswer")
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.goGameButton.setTitle("Начать заново", for: .normal)
                        self.winLabel.text = "Ваш выигрыш составляет \n\(self.fireproofWin) RUB"
                    }
                }
            }
            else if numOfQuestion - 1 == 4 || numOfQuestion - 1 == 9 {
                fireproofWin = winMoney
                audioPlayer.playSound(soundName: "correctAnswer")
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.winLabel.text = "Ваш выигрыш составляет \n\(self.winMoney) RUB"
                    }
                }
            }
            else if numOfQuestion - 1 == 14 {
                audioPlayer.playSound(soundName: "correctAnswer")
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    UIView.animate(withDuration: 0.4) {
                        self.winLabel.isHidden = false
                        self.goGameButton.isHidden = false
                        self.blurView.alpha = 0.8
                        self.goGameButton.setTitle("Начать заново", for: .normal)
                        self.winLabel.text = "Вы победили! \nВаш выигрыш составляет \n\(self.winMoney)"
                    }
                }
            }
            else if timeOff == 0 {
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
}
