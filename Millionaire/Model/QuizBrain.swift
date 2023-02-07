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
    
    
    var currentQuestion: String {
        quiz[questionNumber].ask
    }
    
    mutating func nextQuestion() {
        if questionNumber < quiz.count - 1 {
            questionNumber = questionNumber + 1
        } else {
            reset()
        }
        //questionNumber = (questionNumber < quiz.count - 1) ? questionNumber + 1 : 0
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