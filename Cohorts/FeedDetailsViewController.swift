//
//  FeedDetailsViewController.swift
//  Cohorts
//
//  Created by Gotlib on 10.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import Foundation
import UIKit

class FeedDetailsViewController: UIViewController {
    
    @IBOutlet weak var big_image: UIImageView!
    @IBOutlet weak var logo_image: UIImageView!
    @IBOutlet weak var content_name: UILabel!
    @IBOutlet weak var content_time: UILabel!
    @IBOutlet weak var news_title: UILabel!
    @IBOutlet weak var news_text: UILabel!
    @IBOutlet weak var scroll_view: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(back))
        leftGesture.direction = .right
        self.view.addGestureRecognizer(leftGesture)
        

        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        ///=================================================== ----- backBtn ----- ===================================================
        let backBtn = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        let image: UIImage = UIImage(named: "back_btn")!
        backBtn.image = image
        //set other properties for your button
        //set traget and action
        self.navigationItem.leftBarButtonItem = backBtn
        ///=================================================== ----- ------- ----- ===================================================
        news_text.text = "Seize jours après la chute du président Blaise Compaoré, le Burkina Faso a un nouveau chef d'EtatA l'issue d'ultimes tractions, civils et militaires se sont accordés, lundi 17 novembre, sur le nom du diplomate Michel KafandoSeize jours après la chute du président Blaise Compaoré, le Burkina Faso a un nouveau chef d'EtatA l'issue d'ultimes tractions, civils et militaires se sont accordés, lundi 17 novembre, sur le nom du diplomate Michel Kafando Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
        news_text.numberOfLines = 0 
        news_text.sizeToFit()
//        scroll_view.contentSize = CGSize(width: self.view.frame.size.width, height:1000)
//        var contentRect = CGRect.zero
//        let view
//        for  view in self.scroll_view.subviews {
//            contentRect = contentRect.union(view.frame);
//        }
//        scroll_view.contentSize = contentRect.size;
    }
    func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }

}
