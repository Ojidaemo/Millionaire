//
//  ViewController.swift
//  Millionaire
//
//  Created by Vitali Martsinovich on 2023-02-06.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nicknameField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameField.delegate = self
        
    }
    
    @IBAction func rulesButtonPressed(_ sender: UIButton) {
        
        let rulesVС = RulesViewController()
        self.present(rulesVС, animated: true)
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func nicknamePressed(_ sender: Any) {
    }
    
    
    @IBAction func resultsPressed(_ sender: Any) {
    }
    
    
    // activation of return button on keyboard and hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameField.endEditing(true)
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

