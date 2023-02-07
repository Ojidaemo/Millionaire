//
//  QuestionsViewController.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Лерочка on 05.02.2023.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    var numOfQuestion = 0
    var status = ""
    var questionsArray: [UIButton] = []
    var quiz = QuizBrain()
    
    @IBOutlet weak var firstQuestion: UIButton!
    
    @IBOutlet weak var secondQuestion: UIButton!
    
    @IBOutlet weak var thirdQuestion: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsArray = [ firstQuestion, secondQuestion, thirdQuestion ]
        
        print(status)
        for i in 0..<questionsArray.count {
            if numOfQuestion - 1 == i && status == "right" {
                questionsArray[i].backgroundColor = .green
            }
            else if numOfQuestion - 1 == i && status == "wrong" {
                questionsArray[i].backgroundColor = .red
            }
        }
    }
     
    @IBAction func backToGame(_ sender: Any) {
        quiz.nextQuestion()
    }
}
