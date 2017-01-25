//
//  AddViewController.swift
//  Cohorts
//
//  Created by Gotlib on 12.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var style_from_top: NSLayoutConstraint!
    @IBOutlet weak var view_style: UIView!
    @IBOutlet weak var underline_button: UIButton!
    @IBOutlet weak var italic_button: UIButton!
    @IBOutlet weak var bold_button: UIButton!
    @IBOutlet weak var created_photo: UIImageView!
    @IBOutlet weak var text_view: UITextView!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add"
        picker.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(addTapped))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
               // Do any additional setup after loading the view.
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
           print("keyboardHeight: \(keyboardHeight)")
            print(keyboardHeight)
            style_from_top.constant = view.frame.size.height - keyboardHeight - 30
            view_style.isHidden = false
            underline_button.isHidden = false
            bold_button.isHidden = false
            italic_button.isHidden = false
        }
    }
    func keyboardWillHide(notification: NSNotification) {
            underline_button.isHidden = true
            bold_button.isHidden = true
            italic_button.isHidden = true
            view_style.isHidden = true

    }
    
    func addTapped() {
        self.manual_select("weew")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let alertController = UIAlertController(title: "How you will add?", message: "", preferredStyle: .alert)
        let add_manualy = UIAlertAction(title: NSLocalizedString("Add manualy", comment: "Add manualy"), style: .default, handler: {(action: UIAlertAction) -> Void in
            //Add your code
//            self.manual_select("weew")
            print("cancel action")
        })
        let add_link = UIAlertAction(title: NSLocalizedString("Add link", comment: "Add link"), style: .default, handler: {(action: UIAlertAction) -> Void in
            //Your code
            self.link_select("weew")
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "cancel action"), style: .default, handler: {(action: UIAlertAction) -> Void in
            print("cancel action")
        })
        alertController.addAction(add_manualy)
        alertController.addAction(add_link)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func photoFromLibrary(_ p:String) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func manual_select(_ p:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectorViewController") as! SelectorViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    func link_select(_ p:String) {
        let alertController = UIAlertController(title: "URL", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            
            let linkTextField = alertController.textFields![0] as UITextField
            
            print("Link is: \(linkTextField.text)")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "https://example.com"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var add_image_button: UIButton!
    @IBAction func add_image_action(_ sender: Any) {
        let alertController = UIAlertController(title: "Select image", message: "", preferredStyle: .alert)
        let add_manualy = UIAlertAction(title: NSLocalizedString("From Galery", comment: "From Galery"), style: .default, handler: {(action: UIAlertAction) -> Void in
            //Add your code
            self.photoFromLibrary("weew")
        })
        let add_link = UIAlertAction(title: NSLocalizedString("Take a Photo", comment: "Take a Photo"), style: .default, handler: {(action: UIAlertAction) -> Void in
            //Your code
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "cancel action"), style: .default, handler: {(action: UIAlertAction) -> Void in
            print("cancel action")
        })
        alertController.addAction(add_manualy)
        alertController.addAction(add_link)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        created_photo.contentMode = .scaleAspectFit //3
        created_photo.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func didTapButton(sender: UIButton) {
//        let range = text_view.selectedRange
//        let string = NSMutableAttributedString(attributedString: text_view.attributedText)
//        let attributes = [NSForegroundColorAttributeName: UIColor.red]
//        string.addAttributes(attributes, range: text_view.selectedRange)
//        text_view.attributedText = string
//        text_view.selectedRange = range
//    }
    
    
    @IBAction func make_underline(_ sender: Any) {
        let range = text_view.selectedRange
        let string = NSMutableAttributedString(attributedString: text_view.attributedText)
        let attributes = [NSUnderlineStyleAttributeName : 1]
        string.addAttributes(attributes, range: text_view.selectedRange)
        text_view.attributedText = string
        text_view.selectedRange = range
    }
    
    @IBAction func make_italic(_ sender: Any) {
        let range = text_view.selectedRange
        let string = NSMutableAttributedString(attributedString: text_view.attributedText)
        let attributes = [NSFontAttributeName : UIFont.italicSystemFont(ofSize: 15)]
        string.addAttributes(attributes, range: text_view.selectedRange)
        text_view.attributedText = string
        text_view.selectedRange = range
    }
    @IBAction func make_bold(_ sender: Any) {
        let range = text_view.selectedRange
        let string = NSMutableAttributedString(attributedString: text_view.attributedText)
        let attributes = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        string.addAttributes(attributes, range: text_view.selectedRange)
        text_view.attributedText = string
        text_view.selectedRange = range
    }
//    ==========
    
    
    
//    let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
//    let add_manualy = UIAlertAction(title: NSLocalizedString("Add news manualy", comment: "Add news manualy"), style: .default, handler: {(action: UIAlertAction) -> Void in
//        //Add your code
//    })
//    let add_link = UIAlertAction(title: NSLocalizedString("Add a link", comment: "Add a link"), style: .default, handler: {(action: UIAlertAction) -> Void in
//        //Your code
//        let alertController1 = UIAlertController(title: "Add New Card", message: "", preferredStyle: .alert)
//        
//        let saveAction = UIAlertAction(title: "Add new card", style: .default, handler: {
//            alert -> Void in
//            
//            let firstTextField = alertController1.textFields![0] as UITextField
//            //                let secondTextField = alertController1.textFields![1] as UITextField
//            
//            print("firstName \(firstTextField.text)")
//        })
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
//            (action : UIAlertAction!) -> Void in
//            
//        })
//        
//        alertController1.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter Link"
//        }
//        //            alertController1.addTextField { (textField : UITextField!) -> Void in
//        //                textField.placeholder = "Enter Second Link"
//        //            }
//        
//        alertController1.addAction(saveAction)
//        alertController1.addAction(cancelAction)
//        
//        self.present(alertController1, animated: true, completion: nil)
//    })
//    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "cancel action"), style: .default, handler: {(action: UIAlertAction) -> Void in
//        print("cancel action")
//    })
//    alertController.addAction(add_manualy)
//    alertController.addAction(add_link)
//    alertController.addAction(cancelAction)
//    self.present(alertController, animated: true, completion: nil)
}
