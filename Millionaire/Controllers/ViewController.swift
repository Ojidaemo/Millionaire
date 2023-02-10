//
//  ViewController.swift
//  Millionaire
//
//  Created by Vitali Martsinovich on 2023-02-06.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nicknameField: UITextField!
    var status = false
    var result = Result(name: "", winMoney: "")
    var results: [Result] {
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "kToDoHomeWorkDataSource")
                UserDefaults.standard.synchronize()
            }
        }
        
        get {
            if let data = UserDefaults.standard.value(forKey: "kToDoHomeWorkDataSource") as? Data,
               let array = try? JSONDecoder().decode([Result].self, from: data) {
                return array
            } else {
                return []
            }
        }
    }
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //results.removeAll()
        nicknameField.delegate = self
        saveResults()
    }
    
    @IBAction func rulesButtonPressed(_ sender: UIButton) {
        
        let rulesVС = RulesViewController()
        self.present(rulesVС, animated: true)
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        if nicknameField.text != "" {
            result.name = nicknameField.text!
            result.winMoney = ""
            results.append(result)
        }
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
    
    func saveResults() {
        
        if status {
            for res in results.indices {
                print(res)
                result.name = results[res].name
                print(result.name)
                if res == results.count - 1 {
                    results.append(result)
                }
            }
        }
        print(results)
        for res in results.indices {
            print(res)
            if results[res].name == "" || results[res].winMoney == "" {
                results.remove(at: res)
                break
            }
        }
        print("newwwwwwwwwwwwwwww",results)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

