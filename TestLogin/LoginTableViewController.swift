//
//  LoginTableViewController.swift
//  TestLogin
//
//  Created by Anton C on 25/06/2019.
//  Copyright © 2019 Anton Zdasiuk. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {
    
    var passedItems : [Character : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCountCell", for: indexPath)
        
        let keysArray = Array(passedItems.keys)
        let valuesArray = Array(passedItems.values)
        
        let currentKey = keysArray[indexPath.row]
        let currentValue = valuesArray[indexPath.row]
        
        cell.textLabel?.text = "\"\((currentKey == " " ? "space" : "\(currentKey)"))\" — \(currentValue) " + pluralStringTime(for: currentValue)
        cell.textLabel?.textColor = .black

        return cell
    }
    
    func pluralStringTime(for currentValue: Int) -> String {
        switch currentValue {
        case 1:
            return "time"
        default:
            return "times"
        }
    }
}
