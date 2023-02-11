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
    
    var answersForHelpHint: [String] {
            var result = [String]()
            for _ in 0...69 {
                result.append(quiz[questionNumber].correctAnswer)
            }
            for _ in 0...9 {
                for answer in quiz[questionNumber].wrongAnswers.indices {
                    result.append(quiz[questionNumber].wrongAnswers[answer])
                }
            }
            result.removeLast()
            return result
        }
    var answersForCallHint: [String] {
            var result = [String]()
            for _ in 0...79 {
                result.append(quiz[questionNumber].correctAnswer)
            }
            for _ in 0...6 {
                for answer in quiz[questionNumber].wrongAnswers.indices {
                    result.append(quiz[questionNumber].wrongAnswers[answer])
                }
            }
            result.removeLast()
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
