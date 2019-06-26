//
//  ViewController.swift
//  TestLogin
//
//  Created by Anton C on 25/06/2019.
//  Copyright © 2019 Anton Zdasiuk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var recievedData : Responce?
    
    var characterCount : [Character : Int] = [:]
    
    var ifDenied : Bool = true
    
    let url = URL(string: "http://slotsup.tripland.net/api/login")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let destinationVC = segue.destination as! LoginTableViewController
            destinationVC.passedItems = characterCount
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        let loginFieldText = loginField.text!
        let passwordFieldText = passwordField.text!
        
        request(login: loginFieldText, password: passwordFieldText)
    }
    
    func request(login: String, password: String) {
        
        if loginField.text == "" && passwordField.text == "" {
            self.showAlert(message: "Please enter valid Login and Password", title: "", buttonTitle: "OK", style: .default)
        } else {
       
        let parameters = "login="+login+"&password="+password
    
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = try? JSONDecoder().decode(Responce.self, from: data) {
                    self.recievedData = dataString
                    if self.recievedData?.data.access == "1" {
                        let dictionary = self.recievedData?.data.text.reduce([:]) { (d, c) -> Dictionary<Character,Int> in
                            var d = d
                            let i = d[c] ?? 0
                            d[c] = i+1
                            return d
                    }
                        self.characterCount = dictionary!
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showDetails", sender: nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(message: "Access denied. Please try again.", title: "", buttonTitle: "Cancel", style: .cancel)
                        }
                    }
                }
            }
            }
        task.resume()
        }
    }
    
    func showAlert(message: String, title: String, buttonTitle: String, style: UIAlertAction.Style) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: buttonTitle, style: style) { (action: UIAlertAction) in }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
    }
}
