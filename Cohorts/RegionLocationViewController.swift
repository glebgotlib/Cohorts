//
//  RegionLocationViewController.swift
//  Cohorts
//
//  Created by Gotlib on 15.01.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

import UIKit

class RegionLocationViewController: UIViewController {

    @IBOutlet weak var turn_on_location_butt: UIButton!
    @IBOutlet weak var swicher: UISwitch!
    @IBOutlet weak var view_with_description: UIView!
    @IBOutlet weak var your_location_label: UILabel!
    @IBOutlet weak var auto_view: UIView!
    @IBOutlet weak var bottom_view: UIView!
    
    @IBOutlet weak var toptodescr: NSLayoutConstraint!
    
    @IBOutlet weak var toautoview: NSLayoutConstraint!
    
    
    @IBAction func swich_position(_ sender: Any) {
        if swicher.isOn {
            view_with_description.isHidden = false

            view.addConstraint(NSLayoutConstraint(item: bottom_view, attribute: .top, relatedBy: .equal, toItem: auto_view, attribute: .bottom, multiplier: 1, constant: 275))

            
            view.addConstraint(NSLayoutConstraint(item: view_with_description, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: view_with_description, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: view_with_description, attribute: .top, relatedBy: .equal, toItem: auto_view, attribute: .bottom, multiplier: 1, constant: 10))
            view.addConstraint(NSLayoutConstraint(item: view_with_description, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 245))
            toautoview.constant = 250
            toptodescr.constant = 10
        } else {
            view_with_description.isHidden = true
            toautoview.constant = 10
            toptodescr.constant = -240
        }
        view.updateConstraints()

    }
    
    @IBAction func turn_on_location_action(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addConstraint(NSLayoutConstraint(item: bottom_view, attribute: .top, relatedBy: .equal, toItem: auto_view, attribute: .bottom, multiplier: 1, constant: 10))

        
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.isNavigationBarHidden = false
        turn_on_location_butt.layer.cornerRadius = 3;
        turn_on_location_butt.layer.borderWidth = 1;
        turn_on_location_butt.layer.borderColor = UIColor.gray.cgColor
        
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
