//
//  GameViewController.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Yelena Gorelova on 06.02.2023.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var winMoney: UILabel!
    @IBOutlet weak var numOfQuestion: UILabel!
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var moneyButton: UIButton!
    
    var shuffledAnswers: [String] = []
    var num = 0
    var secondRemaining = 30 // needs to be changed to 30 sec
    var timer = Timer()
    var audioPlayer = AudioPlayer()
    var quiz = QuizBrain()
    var takeMoney = false
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print(" view did disappear")
        audioPlayer.player.stop()
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        audioPlayer.player.stop()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("questionnumber \(num)")
        print("\(quiz.winMoney) RUB")
        print("\(quiz.currentQuestion)")
        
        
        // by default interaction with moneyButton is disabled since player cannot withdraw anything until he provides correct answers to the first question
        
        if num > 0 {
            moneyButton.isUserInteractionEnabled = true
        }
        
        audioPlayer.playSound(soundName: "timer")
        updateUI()
        callTimer()
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
                
        let userAnswer = sender.currentTitle!
        let userGotItRight = quiz.checkAnswer(userAnswer)
        // остановить таймер
        timer.invalidate()
        
        //после выбора ответа убираем возможность нажимать на кнопки
        for button in answerButtons {
            button.isEnabled = false
        }
        sender.self.isEnabled = true
        sender.self.isUserInteractionEnabled = false
        
        
        // подсветить выбранный вариант пока ждем перехода + музыка
        sender.setBackgroundImage(UIImage(named: "Rectangle yellow"), for: .normal)
        audioPlayer.playSound(soundName: "answerAccepted")
        
        // таймер для задержки перехода
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            
            if userGotItRight {
                self.quiz.answerStatus = "right"
            } else {
                self.quiz.answerStatus = "wrong"
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
            questionsVC?.takeMoney = takeMoney
            quiz.questionNumber -= 1
            if quiz.questionNumber != -1 {
                questionsVC?.winMoney = quiz.winMoney
            } else {
                questionsVC?.timeOff = 0
            }
            if quiz.questionNumber >= 4 &&  quiz.questionNumber < 9 {
                questionsVC?.fireproofWin = "1000"
            } else if quiz.questionNumber >= 9 {
                questionsVC?.fireproofWin = "32000"
            }
            quiz.questionNumber += 1
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
    
    // Timer and some UI changes based on the timer's logic
    func callTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.secondRemaining > 0 {
                self.secondRemaining -= 1
                self.timerLabel.text = "\(self.secondRemaining)"
            } else {
                timer.invalidate()
                // делаем задержку перед переходом и отображаем инфу в лейбле для понимания произошедшего
                self.timerLabel.text = "Время вышло!"
                self.timerLabel.textColor = .red
                self.timerLabel.font = .systemFont(ofSize: 20, weight: .bold)
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    self.performSegue(withIdentifier: "goToQuestions", sender: self)
                }
            }
        }
    }
    
    @IBAction func takeMoneyPressed(_ sender: UIButton) {
 
        // остановить таймер
        timer.invalidate()
        
        // we present data on the next screen based on this bool value
        
        takeMoney = true
        
        self.performSegue(withIdentifier: "goToQuestions", sender: self)
    }
}
