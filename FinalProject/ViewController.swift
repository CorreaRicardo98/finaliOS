//
//  ViewController.swift
//  FinalProject
//
//  Created by Mac17 on 17/06/21.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController,GIDSignInDelegate {
    
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil{
            let credencial = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            
            Auth.auth().signIn(with: credencial) { (Aresult, error) in
                if let result = Aresult,error == nil{
                    print("logueo sin problemas")
                    self.performSegue(withIdentifier: "entrada", sender: self)
                }else{
                    print("error: \(error?.localizedDescription)")
                }
            }
        }
    }

    @IBAction func singInGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

