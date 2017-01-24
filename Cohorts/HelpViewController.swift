//
//  HelpViewController.swift
//  Cohorts
//
//  Created by Gotlib on 22.01.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

import UIKit
import MessageUI

class HelpViewController: UIViewController, UIWebViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var web_view: UIWebView!
    @IBOutlet weak var helpfull_label: UILabel!
    @IBOutlet weak var contact_us_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "Help"
        web_view.delegate = self
        web_view.loadRequest(URLRequest(url: URL(string: "http://apple.com")!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contact_us_action(_ sender: Any) {
        self.sendEmail()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
