//
//  SettingsViewController.swift
//  Cohorts
//
//  Created by Gotlib on 12.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var pass_and_secur: UIButton!
    @IBOutlet weak var connected_acc: UIButton!
    @IBOutlet weak var region_location: UIButton!
    @IBOutlet weak var notifications: UIButton!
    @IBOutlet weak var selected_topics: UIButton!
    @IBOutlet weak var automaticaly_adj_label: UILabel!
    @IBOutlet weak var help: UIButton!
    @IBOutlet weak var report_problem: UIButton!
    @IBOutlet weak var give_feedback: UIButton!
    @IBOutlet weak var privicy_policy: UIButton!
    @IBOutlet weak var terms_of_use: UIButton!
    @IBOutlet weak var sign_out: UIButton!
    @IBOutlet weak var Copiright_label: UILabel!
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        signOutButton.layer.cornerRadius = 3;
        signOutButton.layer.borderWidth = 1;
        signOutButton.layer.borderColor = UIColorFromRGB(rgbValue: 0xC8C7CC).cgColor
        self.tabBarController?.tabBar.isHidden = false
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.tabBarController?.tabBar.isHidden = false

    }

    @IBAction func sign_out_action(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([])
        mailVC.setSubject("Subject for email")
        mailVC.setMessageBody("Email message string", isHTML: false)
        
        present(mailVC, animated: true, completion: nil)
    }

    @IBAction func report_a_problem(_ sender: Any) {
       self.sendEmail()
    }
    @IBAction func send_feedback(_ sender: Any) {
        self.sendEmail()
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
