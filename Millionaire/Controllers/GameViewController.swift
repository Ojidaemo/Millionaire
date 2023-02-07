//
//  GameViewController.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Yelena Gorelova on 06.02.2023.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var winMoney: UILabel!
    @IBOutlet weak var numOfQuestion: UILabel!
    @IBOutlet weak var currentQuestion: UILabel!
    
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    
    @IBOutlet weak var secondAnswerButton: UIButton!
    
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    
    var quiz = QuizBrain()
    var answerButtons: [UIButton] = []
    var shuffledAnswers: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
         answerButtons = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]
        print(quiz.currentAnswers)
       updateUI()

    }
    

    func updateUI() {
        numOfQuestion.text = "Вопрос: \(quiz.questionNumber+1)"
        currentQuestion.text = quiz.currentQuestion
        shuffledAnswers = quiz.currentAnswers.shuffled()
        for index in answerButtons.indices {
            let button = answerButtons[index]
            if index < shuffledAnswers.count {
                button.setTitle(shuffledAnswers[index], for: .normal)
            }
        }
    }
    
    
  
    
    @IBAction func takeMoneyPressed(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    
    @IBAction func chooseAnswerPressed(_ sender: UIButton) {
        
        
    }
    
}
