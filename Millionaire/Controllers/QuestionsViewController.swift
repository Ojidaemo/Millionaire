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
    var questionsArray: [UIImageView] = []
    var quiz = QuizBrain()
    var winMoney = ""
    var fireproofWin = "0"
    var audioPlayer = AudioPlayer()

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
        
        
        buttonBackToGame.isHidden = true
        
        questionsArray = [ firstQuestion, secondQuestion, thirdQuestion, fourthQuestion, fifthQuestion, sixthQuestion, seventhQuestion, eighthQuestion, ninthQuestion, tenthQuestion, eleventhQuestion, twelfthQuestion, thirteenthQuestion, fourteenthQuestion, fifteenthQuestion ]

        print(status)
        
        for i in 0..<questionsArray.count {
            if numOfQuestion - 1 == i && status == "right" && i != 4 && i != 9 && i != 14 {
                winLabel.isHidden = false
                goGameButton.isHidden = false
                winLabel.text = "Ваш выигрыш составляет \n\(winMoney)"
                questionsArray[i].image = UIImage(named: "RectangleGreen.png")
                // add sound + show button with basic text
                audioPlayer.playSound(soundName: "correctAnswer")
                buttonBackToGame.isHidden = false
                //questionsArray[i].backgroundColor = .green
            }
            else if numOfQuestion - 1 == i && status == "wrong" && i != 4 && i != 9 && i != 14 {
                winLabel.isHidden = false
                goGameButton.isHidden = false
                goGameButton.titleLabel?.text = "Начать заново"
                winLabel.text = "Ваш выигрыш составляет \n\(fireproofWin)"
                questionsArray[i].image = UIImage(named: "Rectangle red")
                
                // add sound + change button's title
                audioPlayer.playSound(soundName: "wrongAnswer")
                buttonBackToGame.setTitle("Начать заново", for: .normal)
                buttonBackToGame.isHidden = false
                //questionsArray[i].backgroundColor = .red
            }
            else if numOfQuestion - 1 == 4 || numOfQuestion - 1 == 9 {
                fireproofWin = winMoney
                winLabel.isHidden = false
                winLabel.text = "Ваш выигрыш составляет \n\(winMoney)"
                
            }
            else if numOfQuestion - 1 == 14 {
                winLabel.isHidden = false
                winLabel.text = "Вы победили! \nВаш выигрыш составляет \n\(winMoney)"
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
        
//        if sender.currentTitle == "Коснитесь, чтобы продолжить..." {
//            quiz.nextQuestion()
//        } else {
//        //TODO: the game should start from the beginning
//        
//        }

    }
    
}
