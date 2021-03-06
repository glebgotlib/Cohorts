//
//  TermsViewController.swift
//  Cohorts
//
//  Created by Gotlib on 22.01.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var web_view: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        web_view.delegate = self
        web_view.loadRequest(URLRequest(url: URL(string: "http://apple.com")!))
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
