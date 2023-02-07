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
    var questionsArray: [UIImageView] = []
    var quiz = QuizBrain()
    

    @IBOutlet weak var thirdQuestion: UIImageView!
    @IBOutlet weak var firstQuestion: UIImageView!
    
    @IBOutlet weak var secondQuestion: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsArray = [ firstQuestion, secondQuestion, thirdQuestion ]

        print(status)
        for i in 0..<questionsArray.count {
            if numOfQuestion - 1 == i && status == "right" && i != 4 && i != 9 && i != 14 {
                questionsArray[i].image = UIImage(named: "RectangleGreen.png")
                //questionsArray[i].backgroundColor = .green
            }
            else if numOfQuestion - 1 == i && status == "wrong" && i != 4 && i != 9 && i != 14 {
                questionsArray[i].image = UIImage(named: "Rectangle red")
                //questionsArray[i].backgroundColor = .red
            }
        }
    }
     
    @IBAction func backToGame(_ sender: Any) {
        quiz.nextQuestion()
    }
}
