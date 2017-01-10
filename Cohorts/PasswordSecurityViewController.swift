//
//  PasswordSecurityViewController.swift
//  Cohorts
//
//  Created by Gotlib on 11.01.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

import UIKit

class PasswordSecurityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var verify_view: UIView!
    @IBOutlet weak var email_view: UIView!

    @IBAction func switch_position(_ sender: UISwitch) {
        if switcher.isOn {
            verify_view.isHidden = false
            email_view.isHidden = false
        } else {
            verify_view.isHidden = true
            email_view.isHidden = true
        }
    }

    @IBOutlet weak var switcher: UISwitch!
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
