//
//  ViewController.swift
//  Cohorts
//
//  Created by Gotlib on 07.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import UIKit

class LogInView: UIViewController {
    @IBOutlet weak var input_login: UITextField!
    @IBOutlet weak var input_password: UITextField!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var forgot_password: UIButton!
    
    @IBAction func continue_as_guest_action(_ sender: Any) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FeedLine") as! FeedLine
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        self.performSegue(withIdentifier: "mySegueIdentifier", sender: nil)
    }
    @IBAction func reg_button_action(_ sender: UIButton) {
        self.performSegue(withIdentifier: "go_to_registration", sender: nil)
    }
    @IBAction func login_action(_ sender: Any) {
        let myUrl = URL(string: "http://46.101.230.138:4040/v0.2/login?email=\(self.input_login.text!)&password=\(self.input_password.text!)");
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "GET"// Compose a query string
        
//        let json = "user[password]=\(self.pass_text_field.text!)&user[name]=\(self.full_name_text_field.text!)&user[email]=\(self.email_text_field.text!)"
//        print("json= \(json)")
//        request.httpBody = json.data(using: String.Encoding.utf8);
        
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print("ANSVER= \(json)")
                if let parseJSON = json {
                    
                    // Now we can access value of First Name by its key
                    let access_token = parseJSON["access_token"] as? String
                    print("access_token: \(access_token)")
                    
                    if access_token != nil{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "mySegueIdentifier", sender: nil)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()

//        self.performSegue(withIdentifier: "mySegueIdentifier", sender: nil)
    }
    @IBAction func forgot_password_action(_ sender: Any) {
    }
    @IBOutlet weak var login_via_facebook_action: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        login_button.layer.cornerRadius = 3;
        login_button.layer.borderWidth = 1;
        login_button.layer.borderColor = UIColor.gray.cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

