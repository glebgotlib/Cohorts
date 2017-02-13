//
//  AddWebViewViewController.swift
//  Cohorts
//
//  Created by Gotlib on 03.02.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

import UIKit

class AddWebViewViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        let bundle = Bundle.main
        let path = bundle.path(forResource: "index", ofType: "html")
        webView.loadRequest(URLRequest(url: URL(string: path!)!))
        
        
        let items: NSMutableArray = []
        let bold = UIBarButtonItem(title: "title", style: .plain, target: self, action:#selector(boldB))
        let italic = UIBarButtonItem(title: "title", style: .plain, target: self, action:#selector(italicB))
        let underline = UIBarButtonItem(title: "title", style: .plain, target: self, action:#selector(underlineB))

        items.add(bold)
        items.add(italic)
        items.add(underline)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
    }

    func addTapped() {
        let doc = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")
        print("Link is: \(doc)")

    }
    
    func boldB() {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"Bold\")")
    }
    
    func italicB() {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"Italic\")")

    }
    
    func underlineB() {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"Underline\")")

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
