//
//  AddViewController.swift
//  Cohorts
//
//  Created by Gotlib on 12.11.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

import UIKit

class AddViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UIScrollViewDelegate {

    @IBOutlet weak var link_button: UIButton!
    @IBOutlet weak var text_format: UIView!
    @IBOutlet weak var text_format_view: NSLayoutConstraint!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var bottom_margin_of_photo: NSLayoutConstraint!
    @IBOutlet weak var height_of_image: NSLayoutConstraint!
    @IBOutlet weak var style_from_top: NSLayoutConstraint!
    @IBOutlet weak var view_style: UIView!
    @IBOutlet weak var italic_button: UIButton!
    @IBOutlet weak var bold_button: UIButton!
    @IBOutlet weak var created_photo: UIImageView!
    var timer: Timer! = nil
    
//    @IBOutlet weak var text_view: UITextView!
    let picker = UIImagePickerController()
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    func cropBottomImage(image: UIImage) -> UIImage {
        let height = CGFloat(image.size.height / 3)
        let rect = CGRect(x: 0, y: image.size.height - height, width: image.size.width, height: height)
        return cropImage(image: image, toRect: rect)
    }
    
    func removeInputAccessoryView() {
        // locate accessory view
        let windowCount = UIApplication.shared.windows.count
        if (windowCount < 2) {
            return;
        }
        
        let tempWindow:UIWindow = UIApplication.shared.windows[1] as UIWindow
        let accessoryView:UIView = traverseSubViews(vw: tempWindow)
        if (accessoryView.description.hasPrefix("<UIWebFormAccessory")) {
            // Found the inputAccessoryView UIView
            accessoryView.removeFromSuperview()
        }
    }
    
    func traverseSubViews(vw:UIView) -> UIView
    {
        if (vw.description.hasPrefix("<UIWebFormAccessory")) {
            return vw
        }
        
        for i in (0  ..< vw.subviews.count) {
            let subview = vw.subviews[i] as UIView;
            if (subview.subviews.count > 0) {
                let subvw = self.traverseSubViews(vw: subview)
                if (subvw.description.hasPrefix("<UIWebFormAccessory")) {
                    return subvw
                }
            }
        }
        return UIView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Load the pages that are now on screen
        print("did scroll")
        self.view.endEditing(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: nil) { (notification) in
            
            if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                self.removeInputAccessoryView()
            }
        }
        scroll_view.delegate = self
        self.title = "Add"
        picker.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(addTapped))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
//        self.automaticallyAdjustsScrollViewInsets = false
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
//        navigationItem.rightBarButtonItem = bold
        
        let highlightMenuItem = UIMenuItem(title: "Highlight", action: #selector(highlight));

        UIMenuController.shared.menuItems = [highlightMenuItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
//        text_format.isHidden = false

        let alertController = UIAlertController(title: "Submit a new ...", message: "", preferredStyle: .actionSheet)
        let add_manualy = UIAlertAction(title: NSLocalizedString("Text Post", comment: "Add manualy"), style: .default, handler: {(action: UIAlertAction) -> Void in
            //Add your code
            //            self.manual_select("weew")
            //            print("cancel action")
        })
        let add_link = UIAlertAction(title: NSLocalizedString("Link", comment: "Add link"), style: .default, handler: {(action: UIAlertAction) -> Void in
            //Your code
            self.link_select()
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "cancel action"), style: .default, handler: {(action: UIAlertAction) -> Void in
            print("cancel action")
        })
        alertController.addAction(add_manualy)
        alertController.addAction(add_link)
        alertController.addAction(cancelAction)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkSelection), userInfo: nil, repeats: true);
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("cancel action")
        timer.invalidate()
        timer = nil
    }
    
    
    func checkSelection() -> Bool  {
        let selection = webView.stringByEvaluatingJavaScript(from: "window.getSelection().toString()")
        print("Link is: \(selection)")
        if  selection != ""
        {
//            text_format.isHidden = true
//            view_style.isHidden = false
//            link_button.isHidden = false
//            bold_button.isHidden = false
//            italic_button.isHidden = false
            return true
        }
        else
        {
//            text_format.isHidden = false
//            view_style.isHidden = true
//            link_button.isHidden = true
//            bold_button.isHidden = true
//            italic_button.isHidden = true
            return false
        }
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkSelection), userInfo: nil, repeats: true)
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
           print("keyboardHeight: \(keyboardHeight)")
            print(keyboardHeight)
            style_from_top.constant = view.frame.size.height - keyboardHeight + 14
            text_format_view.constant = view.frame.size.height - keyboardHeight - 50
            if checkSelection()
            {
                text_format.isHidden = true
                view_style.isHidden = false
                link_button.isHidden = false
                bold_button.isHidden = false
                italic_button.isHidden = false

                print("text_format.isHidden = true")

            }
            else
            {
                text_format.isHidden = false
                view_style.isHidden = true
                link_button.isHidden = true
                bold_button.isHidden = true
                italic_button.isHidden = true
                print("text_format.isHidden = false")
            }
            view_style.isHidden = false
            link_button.isHidden = false
            bold_button.isHidden = false
            italic_button.isHidden = false
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        text_format.isHidden = true
//            underline_button.isHidden = true
//            bold_button.isHidden = true
//            italic_button.isHidden = true
        view_style.isHidden = true

    }
    
    func addTapped() {
        let doc = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")
        print("Link is: \(doc)")
//        self.manual_select("weew")
    }
    
    func boldB() {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"justifyCenter\")")
    }
    
    func italicB() {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"Italic\")")
    }
    
    func underlineB() {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"Underline\")")
    }
    
    func highlight() {
        let currentColor = webView.stringByEvaluatingJavaScript(from:"document.queryCommandValue('backColor')")
        if currentColor == "rgb(255, 255, 0)"
        {
            webView.stringByEvaluatingJavaScript(from:"document.execCommand('backColor', false, 'white')")
        } else {
            webView.stringByEvaluatingJavaScript(from: "document.execCommand('backColor', false, 'yellow')")
        }
    }
    
    @IBAction func h1_action(_ sender: Any) {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"formatBlock\", false, \"h1\")")
    }
    
    @IBAction func h2_action(_ sender: Any) {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"formatBlock\", false, \"h2\")")
    }
    
    @IBAction func normal_action(_ sender: Any) {
//        document.execCommand('fontSize', false, '%i'
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"fontSize\", false, \"15\"")
    }
    
    @IBAction func quot_action(_ sender: Any) {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"formatBlock\", false, \"BLOCKQUOTE\")")
    }

    @IBAction func link_action(_ sender: Any) {
//        createLink
        let alertController = UIAlertController(title: "URL", message: "Submit a New Link", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            
            let linkTextField = alertController.textFields![0] as UITextField
            let jscode = String (format: "document.execCommand(\"CreateLink\", false, \"%@\")", linkTextField.text!)
            DispatchQueue.main.async {
                self.webView.stringByEvaluatingJavaScript(from: jscode)
                print("Link is: \(jscode))")
            }
//            self.webView.stringByEvaluatingJavaScript(from: jscode)
//            print("Link is: \(jscode))")
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
    
    @IBAction func bold_action(_ sender: Any) {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"Bold\")")

    }
    
    @IBAction func italic_action(_ sender: Any) {
        webView.stringByEvaluatingJavaScript(from: "document.execCommand(\"Italic\")")
    }
    
    
    func photoFromLibrary(_ p:String) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func manual_select(_ p:String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddWebViewViewController") as! AddWebViewViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    func link_select() {
        let alertController = UIAlertController(title: "URL", message: "Submit a New Link", preferredStyle: .alert)
        
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
        let alertController = UIAlertController(title: "Select image", message: "", preferredStyle: .actionSheet)
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
        created_photo.contentMode = .scaleAspectFill //3
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
    
//    @IBAction func make_underline(_ sender: Any) {
//        let range = text_view.selectedRange
//        let string = NSMutableAttributedString(attributedString: text_view.attributedText)
//        let attributes = [NSUnderlineStyleAttributeName : 1]
//        string.addAttributes(attributes, range: text_view.selectedRange)
//        text_view.attributedText = string
//        text_view.selectedRange = range
//    }
//    
//    @IBAction func make_italic(_ sender: Any) {
//        let range = text_view.selectedRange
//        print("defaults savedString: \(range)")
//        
//        let string = NSMutableAttributedString(attributedString: text_view.attributedText)
//          print("defaults savedString: \(string)")
//
//        let attributes = [NSFontAttributeName : UIFont.italicSystemFont(ofSize: 15)]
//        
//        string.addAttributes(attributes, range: text_view.selectedRange)
//        print("attributes savedString: \(string)")
//
//        text_view.attributedText = string
//        text_view.selectedRange = range
//    }
//    @IBAction func make_bold(_ sender: Any) {
//        let range = text_view.selectedRange
//        let string = NSMutableAttributedString(attributedString: text_view.attributedText)
//        let attributes = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
//        string.addAttributes(attributes, range: text_view.selectedRange)
//        text_view.attributedText = string
//        text_view.selectedRange = range
//    }
    
    
    
//    let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
//    created_photo.isUserInteractionEnabled = true
//    created_photo.addGestureRecognizer(tapGestureRecognizer)
//    
//    // Do any additional setup after loading the view.
//    
//    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
//    //        swipeDown.direction = UISwipeGestureRecognizerDirection.down
//    test_view.addGestureRecognizer(swipeDown)
//}
//
//func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//        switch swipeGesture.direction {
//        case UISwipeGestureRecognizerDirection.right:
//            print("Swiped right")
//        case UISwipeGestureRecognizerDirection.down:
//            print("Swiped down")
//        case UISwipeGestureRecognizerDirection.left:
//            print("Swiped left")
//        case UISwipeGestureRecognizerDirection.up:
//            print("Swiped up")
//        default:
//            break
//        }
//    }
//}
//func imageTapped(img: AnyObject)
//{
//    // Your action
//    print("Swiped right 1333332")
//    
//}
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
