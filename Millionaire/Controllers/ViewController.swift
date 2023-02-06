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

    @IBAction func rulesButtonPressed(_ sender: UIButton) {
        
        let rulesVС = RulesViewController()
        self.present(rulesVС, animated: true)
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        
    }
}

