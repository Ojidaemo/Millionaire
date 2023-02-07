//
//  Question.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Лерочка on 07.02.2023.
//


import Foundation

struct Question: Decodable {
    // let level: Int
    let ask: String
    let correctAnswer: String
    let wrongAnswers: [String]
    
    static func questions() -> [Question] {
        if let url = Bundle.main.url(forResource: "questions",
                                     withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let questions = try decoder.decode([Question].self,
                                                   from: data)
                return questions
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
