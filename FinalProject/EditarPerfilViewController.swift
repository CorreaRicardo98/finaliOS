//
//  EditarPerfilViewController.swift
//  FinalProject
//
//  Created by Mac17 on 21/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class EditarPerfilViewController: UIViewController {
    var id:String = "inexistente"
    var tipo:Int = 1
    var nombre:String = "no"
    var correo:String = "no"
    var direccion:String = "no"
    var telefono:String = "no"
    @IBOutlet weak var nombretf: UITextField!
    @IBOutlet weak var correotf: UITextField!
    @IBOutlet weak var direcciontf: UITextField!
    @IBOutlet weak var telefonotf: UITextField!
    @IBOutlet weak var tipol: UILabel!
    @IBOutlet weak var tipobar: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nombre != "no"{
            nombretf.text = nombre
        }
        if correo != "no"{
            correotf.text = correo
        }
        if direccion != "no"{
            direcciontf.text = direccion
        }
        if telefono != "no"{
            telefonotf.text = telefono
        }
        
        	

        
    }
    
    @IBAction func cambioTipo(_ sender: UISlider) {
        switch Int(sender.value) {
        case 1:
            tipol.text = "comida"
            tipo = Int(sender.value)
            break
        case 2:
            tipol.text = "ropa"
            tipo = Int(sender.value)
            break
        case 3:
            tipol.text = "accesorios"
            tipo = Int(sender.value)
            break
        case 4:
            tipol.text = "automotriz"
            tipo = Int(sender.value)
            break
        
        default:
            tipol.text = "default"
        }
    
    

}
    
    
    @IBAction func guardar(_ sender: UIButton) {
        let db = Firestore.firestore()
        if telefono != "no"{
            db.collection("neocios").document(id).setData([
                "nombre":nombretf.text!,
                "direccion":direcciontf.text!,
                "telefono":telefonotf.text!,
                "correo":correotf.text!,
                "tipo":"\(tipo)"
            ]){ err in
                if let err = err {
                    print("error con los datos: \(err.localizedDescription)")
                }else{
                    print("sin ningun problema")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            db.collection("neocios").addDocument(data: [
                "nombre":nombretf.text!,
                "direccion":direcciontf.text!,
                "telefono":telefonotf.text!,
                "correo":correotf.text!,
                "tipo":"\(tipo)"
            ]){ (error) in
                if let err = error{
                    print("problema: \(err.localizedDescription)")
                }else{
                    print("no hubo problema")
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }

    }
    
}
