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
    var takeMoney = false
    var timer = Timer()
    var quiz = QuizBrain()
    var audioPlayer = AudioPlayer()
  
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet var questionsArray: [UIImageView]!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var goGameButton: UIButton!
    
    // stop music from playing
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioPlayer.player.stop()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        
        if takeMoney == true {
            audioPlayer.playSound(soundName: "win")
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                UIView.animate(withDuration: 0.4) {
                    self.winLabel.isHidden = false
                    self.goGameButton.isHidden = false
                    self.blurView.alpha = 0.8
                    self.goGameButton.setTitle("Начать игру заново", for: .normal)
                    self.winLabel.text = "Ваш выигрыш составляет \n\(self.winMoney) RUB"
                }
            }
        } else {
            for i in 0..<questionsArray.count {
                if numOfQuestion - 1 == i && status == "right" && i != 14{
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
                else if numOfQuestion - 1 == i && status == "wrong" && i != 14{
                    questionsArray[i].image = UIImage(named: "Rectangle red")
                    audioPlayer.playSound(soundName: "wrongAnswer")
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        UIView.animate(withDuration: 0.4) {
                            self.winLabel.isHidden = false
                            self.goGameButton.isHidden = false
                            self.blurView.alpha = 0.8
                            self.goGameButton.setTitle("Начать игру заново", for: .normal)
                            self.winLabel.text = "Ваш выигрыш составляет \n\(self.fireproofWin) RUB"
                        }
                    }
                }
                else if numOfQuestion == 15 && status == "right" {
                    audioPlayer.playSound(soundName: "win")
                    questionsArray[14].image = UIImage(named: "RectangleGreen.png")
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        UIView.animate(withDuration: 0.4) {
                            self.winLabel.isHidden = false
                            self.goGameButton.isHidden = false
                            self.blurView.alpha = 0.8
                            self.goGameButton.setTitle("Начать игру заново", for: .normal)
                            self.winLabel.text = "Вы победили! \nВаш выигрыш составляет \n\(self.winMoney)"
                        }
                    }
                }
                else if numOfQuestion == 15 && status == "wrong" {
                    questionsArray[14].image = UIImage(named: "Rectangle red")
                    audioPlayer.playSound(soundName: "wrongAnswer")
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        UIView.animate(withDuration: 0.4) {
                            self.winLabel.isHidden = false
                            self.goGameButton.isHidden = false
                            self.blurView.alpha = 0.8
                            self.goGameButton.setTitle("Начать игру заново", for: .normal)
                            self.winLabel.text = "Ваш выигрыш составляет \n\(self.fireproofWin)"
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
                            self.goGameButton.setTitle("Начать игру заново", for: .normal)
                            self.winLabel.text = "Ваш выигрыш составляет \n\(self.fireproofWin)"
                        }
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
            } else {
                gameVC?.num = 0
            }
        }
    }
}
