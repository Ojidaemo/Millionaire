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
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerButtons = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]
        updateUI()
        
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let userGotItRight = quiz.checkAnswer(userAnswer)
        
        if userGotItRight {
            quiz.answerStatus = "right"
            print("right")
            
        } else {
            quiz.answerStatus = "wrong"
            print("wrong")
        }
        quiz.nextQuestion()
        num = quiz.questionNumber
        updateUI()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionsViewController {
            let questionsVC = segue.destination as? QuestionsViewController
            questionsVC?.numOfQuestion = quiz.questionNumber
            questionsVC?.status = quiz.answerStatus
        }
    }
    
    func updateUI() {
        quiz.questionNumber = num
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
