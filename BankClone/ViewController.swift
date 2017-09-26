/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var tittleView: UIView!
    
    
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var saveUser: UISwitch!
    // to show a process is being performed 
    var activityIndicator = UIActivityIndicatorView()
    var signupMode = true
    var user = String()
    var pass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //var signedIn = nil
    @IBAction func logIn(_ sender: Any) {
        // Login mode
        let logQueue = DispatchQueue.global(qos: .utility)
        
        if userTF.text == "" || passwordTF.text == "" {
            
            createAlert(title: "Nombre de usario y contraseña invalidos" , message: "Ingrese usuario y contraseña")
            
        } else {
            
            
            user = userTF.text!
            pass = passwordTF.text!
            
            //stop the app activity till we are logged in
            self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents() // UIApplication.shared() is now UIApplication.shared
            
            logQueue.async {
                //make sure we don't move to next view unless we signed in
                PFUser.logInWithUsername(inBackground: self.user, password: self.pass, block: { (user, error) in
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        let error = error as NSError?
                        if let errorMessage = error?.userInfo["error"] as? String {
                            displayErrorMessage = errorMessage
                        }
                        print(displayErrorMessage)
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                        
                        
                    } else {
                        
                        print("Logged in")
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            UIApplication.shared.endIgnoringInteractionEvents() // UIApplication.shared() is now  application.shared
                            self.performSegue(withIdentifier: "toAccountList", sender: self)
                        }
                    }
                    
                })
            }
            
            
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // added functions 
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
