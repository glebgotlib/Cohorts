//
//  ConnectAccountViewController.swift
//  Cohorts
//
//  Created by Gotlib on 15.01.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

import UIKit

class ConnectAccountViewController: UIViewController {

    @IBOutlet weak var fb_indicator: UILabel!
    @IBOutlet weak var tw_indicator: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
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
