//
//  QuizBrain.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Лерочка on 07.02.2023.
//

import Foundation

struct QuizBrain {
    
    let quiz = Question.questions()
    var questionNumber: Int = 14
    var answerStatus = "wrong"
    
    var winMoney: String {
        quiz[questionNumber].winMoney
    }
    
    var currentQuestion: String {
        quiz[questionNumber].ask
    }
    
    mutating func nextQuestion() {
        if questionNumber != quiz.count - 1 {
            questionNumber = questionNumber + 1
        } else if questionNumber == quiz.count - 1 {
            print("RAVNO")
        } else {
            reset()
        }
    }
    
    var currentAnswers: [String] {
        var result = quiz[questionNumber].wrongAnswers
        result.append(quiz[questionNumber].correctAnswer)
        return result
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        if quiz[questionNumber].correctAnswer == answer {
            return true
        } else {
            return false
        }
    }
    
    mutating func reset() {
        questionNumber = 0
    }
}
