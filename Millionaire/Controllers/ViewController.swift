//
//  ViewController.swift
//  Millionaire
//
//  Created by Vitali Martsinovich on 2023-02-06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func RulesButtonPressed(_ sender: UIButton) {
        let rulesVc = RulesViewController()
        self.present(rulesVc, animated: true)
    }
    
    @IBAction func NewGameButtonPressed(_ sender: Any) {
        
    }
}

