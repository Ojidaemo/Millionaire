//
//  QuizBrain.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Лерочка on 07.02.2023.
//

import Foundation

struct QuizBrain {
    
    let quiz = Question.questions()
    var questionNumber: Int = 0
    var answerStatus = "wrong"
    
    var winMoney: String {
        quiz[questionNumber].winMoney
    }
    
    var currentQuestion: String {
        quiz[questionNumber].ask
    }
    
    mutating func nextQuestion() {
        if questionNumber < quiz.count - 1 {
            questionNumber = questionNumber + 1
        }
    }
    
    var currentAnswers: [String] {
        var result = quiz[questionNumber].wrongAnswers
        result.append(quiz[questionNumber].correctAnswer)
        return result
    }
    
    var fiftyHintAnswers: [String] {
        var result = currentAnswers
        result[0] = ""
        result[1] = ""
        //.removeFirst()
        return result
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        if quiz[questionNumber].correctAnswer == answer {
            return true
        } else {
            return false
        }
    }
}
