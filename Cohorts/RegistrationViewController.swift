//
//  RegistrationViewController.swift
//  Cohorts
//
//  Created by Gotlib on 17.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var full_name_text_field: UITextField!
    @IBOutlet weak var pass_text_field: UITextField!
    @IBOutlet weak var sign_up: UIButton!
    
    @IBAction func facebook_registration_action(_ sender: UIButton) {
    }
    @IBAction func avatar_select_action(_ sender: Any) {
    }
    @IBAction func sign_up_action(_ sender: Any) {
//        curl -i -X POST \
//        
//        -F 'email=some@dude.com' \
//        
//        -F 'password=p_n7!-e8' \
//        
//        -F 'name=John Doe' \
//        
//        -F 'picture=@/home/user/Desktop/test.png' \
//        
//        "http://46.101.230.138:4040/users"
        
        let myUrl = URL(string: "http://46.101.230.138:4040/v0.2/users");
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        
        let json = "user[password]=\(self.pass_text_field.text!)&user[name]=\(self.full_name_text_field.text!)&user[email]=\(self.email_text_field.text!)"
        print("json= \(json)")
        request.httpBody = json.data(using: String.Encoding.utf8);
        
        
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
                            self.performSegue(withIdentifier: "regOk", sender: nil)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    @IBAction func policy_action(_ sender: Any) {
    }
    @IBAction func back_to_log_in(_ sender: UIButton) {
        self.performSegue(withIdentifier: "go_back_to_login", sender: nil)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        email_text_field.delegate=self
        full_name_text_field.delegate=self
        pass_text_field.delegate=self
        email_text_field.attributedPlaceholder = NSAttributedString(string: "some@mail.com",
                                                                               attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        full_name_text_field.attributedPlaceholder = NSAttributedString(string: "Full name",
                                                                        attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        pass_text_field.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                   attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
        sign_up.layer.cornerRadius = 3;
        sign_up.layer.borderWidth = 1;
        sign_up.layer.borderColor = UIColorFromRGB(rgbValue: 0xC8C7CC).cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
