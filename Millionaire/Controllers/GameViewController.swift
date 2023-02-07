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
    var answerStatus = "wrong"
    var answerButtons: [UIButton] = []
    var shuffledAnswers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstAnswerButton.setBackgroundImage(UIImage(named: "kk"), for: UIControl.State.normal)
        
        
        answerButtons = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]
        updateUI()
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let userGotItRight = quiz.checkAnswer(userAnswer)
        
        if userGotItRight {
            answerStatus = "right"
            sender.backgroundColor = UIColor.green
            print("right")
            
        } else {
            answerStatus = "wrong"
            sender.backgroundColor = UIColor.red
            print("wrong")
        }
        quiz.nextQuestion()
        updateUI()
     
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionsViewController {
            let vc = segue.destination as? QuestionsViewController
            vc?.numOfQuestion = quiz.questionNumber
            vc?.status = answerStatus
        }
    }
    
    func updateUI() {
        winMoney.text = "\(quiz.winMoney) RUB"
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
