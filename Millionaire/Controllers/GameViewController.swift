//
//  GameViewController.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Yelena Gorelova on 06.02.2023.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var helpHint: UIButton!
    @IBOutlet weak var callHint: UIButton!
    @IBOutlet weak var fiftyHint: UIButton!
    @IBOutlet weak var winMoney: UILabel!
    @IBOutlet weak var numOfQuestion: UILabel!
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var moneyButton: UIButton!
    
    var shuffledAnswers: [String] = []
    var num = 0
    var takeMoneyPressed = false
    var fiftyHintPressed = false
    var callHintPressed = false
    var helpHintPressed = false
    var secondRemaining = 30 // needs to be changed to 30 sec
    var timer = Timer()
    var audioPlayer = AudioPlayer()
    var quiz = QuizBrain()
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioPlayer.player.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.audioPlayer.player.stop()
            self.performSegue(withIdentifier: "goToQuestions", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionsViewController {
            let questionsVC = segue.destination as? QuestionsViewController
            if num != 14 {
                questionsVC?.numOfQuestion = quiz.questionNumber
            } else {
                questionsVC?.numOfQuestion = 15
            }
            questionsVC?.fiftyHint = fiftyHintPressed
            questionsVC?.callHint = callHintPressed
            questionsVC?.helpHint = helpHintPressed
            questionsVC?.status = quiz.answerStatus
            questionsVC?.takeMoney = takeMoneyPressed
            if num != 14 {
                quiz.questionNumber -= 1
            }
            if timerLabel.text != "Время вышло!" {
                questionsVC?.winMoney = quiz.winMoney
            } else {
                questionsVC?.timeOff = 0
            }
            if quiz.questionNumber >= 4 &&  quiz.questionNumber < 9 {
                questionsVC?.fireproofWin = "1000"
            } else if quiz.questionNumber >= 9 {
                questionsVC?.fireproofWin = "32000"
            }
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
        // by default interaction with moneyButton is disabled since player cannot withdraw anything until he provides correct answers to the first question
        if num > 0 {
            moneyButton.isUserInteractionEnabled = true
        }
        if num > 0 && fiftyHintPressed == true {
            fiftyHint.isUserInteractionEnabled = false
            fiftyHint.setBackgroundImage(UIImage(named: "Frame 7"), for: .normal)
        }
        if num > 0 && callHintPressed == true {
            callHint.isUserInteractionEnabled = false
            callHint.setBackgroundImage(UIImage(named: "Frame 9"), for: .normal)
        }
        if num > 0 && helpHintPressed == true {
            helpHint.isUserInteractionEnabled = false
            helpHint.setBackgroundImage(UIImage(named: "Frame 8"), for: .normal)
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
        takeMoneyPressed = true
        
        self.performSegue(withIdentifier: "goToQuestions", sender: self)
    }
    
    @IBAction func fiftyHintButton(_ sender: UIButton) {
        for index in answerButtons.indices {
            var status = 0
            let button = answerButtons[index]
            for answer in quiz.fiftyHintAnswers.indices {
                if button.titleLabel?.text != quiz.fiftyHintAnswers[answer]{
                    status += 1
                }
                if status == 4 {
                    button.isEnabled = false
                    UIView.animate(withDuration: 0.3) {
                        button.alpha = 0
                    }
                }
            }
        }
        sender.self.isUserInteractionEnabled = false
        sender.self.setBackgroundImage(UIImage(named: "Frame 7"), for: .normal)
        fiftyHintPressed = true
    }
    
    
    @IBAction func callHintButton(_ sender: UIButton) {
        let rundomAnswer = quiz.answersForCallHint.randomElement()
        for index in answerButtons.indices {
            let button = answerButtons[index]
            if button.currentTitle == rundomAnswer {
                button.setBackgroundImage(UIImage(named: "Rectangle yellow"), for: .normal)
            }
            
        }
        sender.self.isUserInteractionEnabled = false
        sender.self.setBackgroundImage(UIImage(named: "Frame 9"), for: .normal)
        callHintPressed = true
    }
    
    @IBAction func helpHintButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Мнение зрителей зала:", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in }
        alert.addAction(action)
        let rundomAnswer = quiz.answersForHelpHint.randomElement()
        for index in answerButtons.indices {
            let button = answerButtons[index]
            if button.currentTitle == rundomAnswer {
                alert.message = rundomAnswer
                present(alert, animated: true)
            }
            
        }
        sender.self.isUserInteractionEnabled = false
        sender.self.setBackgroundImage(UIImage(named: "Frame 8"), for: .normal)
        helpHintPressed = true
    }
}
