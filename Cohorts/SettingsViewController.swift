//
//  SettingsViewController.swift
//  Cohorts
//
//  Created by Gotlib on 12.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        signOutButton.layer.cornerRadius = 3;
        signOutButton.layer.borderWidth = 1;
        signOutButton.layer.borderColor = UIColor.gray.cgColor
        // Do any additional setup after loading the view.
    }


    @IBAction func sign_out_action(_ sender: Any) {
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
