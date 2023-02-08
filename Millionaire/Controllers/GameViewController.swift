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
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var firstAnswerButton: UIButton!
    
    @IBOutlet weak var secondAnswerButton: UIButton!
    
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    var audioPlayer = AudioPlayer()
    var quiz = QuizBrain()
    var answerButtons: [UIButton] = []
    var shuffledAnswers: [String] = []
    var num = 0
    var timer = Timer()
    var secondRemaining = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer.playSound(soundName: "timer")
        answerButtons = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton]
        updateUI()
        callTimer()
        
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let userGotItRight = quiz.checkAnswer(userAnswer)
        
        // после выбора ответа надо убрать возможность нажимать на кнопки
        
        // подсветить выбранный вариант пока ждем перехода
//        sender.isEnabled = true
//        sender.setTitleColor(.yellow, for: .normal)
        
        sender.setBackgroundImage(UIImage(named: "Rectangle yellow"), for: .normal)
        audioPlayer.playSound(soundName: "answerAccepted")
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
            
            if userGotItRight {
                self.quiz.answerStatus = "right"
                print("right")
                
            } else {
                self.quiz.answerStatus = "wrong"
                print("wrong")
            }
            self.quiz.nextQuestion()
            self.num = self.quiz.questionNumber
            self.updateUI()
            self.audioPlayer.player.stop()
            self.performSegue(withIdentifier: "goToQuestions", sender: self)
            
        }
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
    
    func callTimer() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.secondRemaining > 0 {
                self.secondRemaining -= 1
                self.timerLabel.text = "\(self.secondRemaining)"
                // добавить музыку "timer.mp3.wav"
            } else {
                timer.invalidate()
            }
        }
    }
    
    
    
    
    @IBAction func takeMoneyPressed(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    
    @IBAction func chooseAnswerPressed(_ sender: UIButton) {
        
        
    }
    
}
