//
//  RegistroViewController.swift
//  FinalProject
//
//  Created by Mac17 on 18/06/21.
//

import UIKit
import Firebase

class RegistroViewController: UIViewController {
    @IBOutlet weak var correoTexField: UITextField!
    
    @IBOutlet weak var contraseniaTexttField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registro(_ sender: UIButton) {
        if let usuario = correoTexField.text, let contra = contraseniaTexttField.text{
            Auth.auth().createUser(withEmail: usuario, password: contra) { (result, error) in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "Rsegue", sender: self)
                }
                
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
