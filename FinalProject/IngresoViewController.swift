//
//  IngresoViewController.swift
//  FinalProject
//
//  Created by Mac17 on 18/06/21.
//

import UIKit
import Firebase

class IngresoViewController: UIViewController {

    @IBOutlet weak var correoTF: UITextField!

    @IBOutlet weak var passwordTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logIn(_ sender: UIButton) {
        if let correo = correoTF.text, let pass = passwordTF.text{
            Auth.auth().signIn(withEmail: correo, password: pass) { (result, error) in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "ISsegue", sender: self)
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
