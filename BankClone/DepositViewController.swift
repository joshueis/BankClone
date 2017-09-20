//
//  DepositViewController.swift
//  BankClone
//
//  Created by Israel Carvajal on 8/14/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class DepositViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var frontC: UIButton!
    @IBOutlet weak var backC: UIButton!
    
    
    var frontCheck = UIImage()
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var accountPicker: UIPickerView!
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
    }
    
    
    @IBAction func getCheck(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    //MARK: - Done image capture here
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        frontCheck = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    
    @IBAction func deposit(_ sender: Any) {
        
        let post = PFObject(className: "mobileDeposit")
        // do a quick check for max amount allowed and then continue
        
        if let amount = amountTF.text, let imageData = UIImagePNGRepresentation(frontCheck),
            let imageData2 = UIImagePNGRepresentation(frontCheck){

            post["amount"] = amount
            post["userid"] = PFUser.current()?.objectId
            //store the image in a file to post it to data base
            let imageFile = PFFile(name: "front.png", data: imageData)
            post["frontOfCheck"] = imageFile
            //for the back of the check
            let imageFile2 = PFFile(name: "back.png", data: imageData2)
            post["backOfCheck"] = imageFile2
            post.saveInBackground{(success, error) in
                if error != nil{
                    self.createAlert(title: "check could not be deposited at this moment", message: "please try again later")
                }
                else{
                    self.createAlert(title: "Check Deposited", message: "Your balance might take few hours to show the transaction!")
                }
            }
        }
        else{
            self.createAlert(title: "Error!", message: "Missing information")
        }
        
    }
   
   
    @IBOutlet weak var amountTF: UITextField!

    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //button for deposit is not enabled until all info required is available
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
