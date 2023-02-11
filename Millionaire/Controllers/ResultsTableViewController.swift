//
//  ResultsTableViewController.swift
//  Millionaire
//
//  Created by Лерочка on 10.02.2023.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView =  UIImageView(image: UIImage(named: "emptyBack"))
    }
    
    
    @IBAction func returnToMenu(_ sender: Any) {
        dismiss(animated: true)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(result.name) \nВыигрыш составляет \(result.winMoney) RUB"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Результаты"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: "Helvetica-Regular", size: 17)
        
    }
}
