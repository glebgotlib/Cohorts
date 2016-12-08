//
//  FeedLine.swift
//  Cohorts
//
//  Created by Gotlib on 08.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import Foundation
import UIKit

class FeedLine: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var search_top: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        var screenSize: CGRect!
        var screenWidth: CGFloat!

        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth/2-20, height: 246)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView!.collectionViewLayout = layout
    }
     // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.row == 0 || indexPath.row == 7){
            let reuseIdentifier = "FirstCollectionViewCell"
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! FirstCollectionViewCell
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.first_lab.text = self.items[indexPath.item]
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
//          cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
            return cell
        }
        else if(indexPath.row == 1 || indexPath.row == 4)
        {
            let reuseIdentifier = "SecondCollectionViewCell"
            // get a reference to our storyboard cell
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SecondCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell1.first_lab.text = self.items[indexPath.item]
            cell1.layer.borderWidth = 1.0
            cell1.layer.borderColor = UIColor.lightGray.cgColor
            //        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
            return cell1
        }
        else
        {
            let reuseIdentifier = "ThirdCollectionViewCell"
            // get a reference to our storyboard cell
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ThirdCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell2.first_lab.text = self.items[indexPath.item]
            cell2.layer.borderWidth = 1.0
            cell2.layer.borderColor = UIColor.lightGray.cgColor
            //        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
            return cell2
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
