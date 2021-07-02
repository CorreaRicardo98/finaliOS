//
//  PerfilViewController.swift
//  FinalProject
//
//  Created by Mac17 on 21/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore



class PerfilViewController: UIViewController {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var correo: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var telefono: UILabel!
    var documentId:String = "inexistente"
    var nombreS:String!
    var correoS:String!
    var telefonoS:String!
    var direccionS:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        cargar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cargar()
    }
    

    @IBAction func editar(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "editarPerfil", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarPerfil"{
            let vc = segue.destination as! EditarPerfilViewController
            if documentId != "inexistente" {
                vc.id = documentId
                vc.nombre = nombreS
                vc.correo = correoS
                vc.direccion = direccionS
                vc.telefono = telefonoS
            }else{
                vc.id = documentId
                vc.nombre = "no"
                vc.correo = "no"
                vc.direccion = "no"
                vc.telefono = "no"
            }
        }
    }
    func cargar(){
        let db = Firestore.firestore()
        if let user = Auth.auth().currentUser?.email {
            
             db.collection("neocios")
                .whereField("correo", isEqualTo: user)
                .getDocuments { (querySnapShot, error) in
                    if let e = error{
                        print("error al carar los datos: \(e.localizedDescription)")
                    }else{
                        if (((querySnapShot?.isEmpty)) != nil){
                            
                        }else{
                            if let snaposhot = querySnapShot?.documents{
                                let document = snaposhot[0]
                                    print("datos: \(document.data())")
                                if let id = document.documentID as? String{
                                    self.documentId = document.documentID
                                    let dato = document.data()
                                    
                                    guard let nombreD = dato["nombre"] as? String else {
                                        return
                                    }
                                    guard let correoD = dato["correo"] as? String else {
                                        return
                                    }
                                    guard let direccionD = dato["direccion"] as? String else {
                                        return
                                    }
                                    guard let telefonoD = dato["telefono"] as? String else {
                                        return
                                    }
                                    
                                    print("nombre Dato: \(nombreD)")
                                        
                                        self.nombre.text = nombreD
                                        self.correo.text = correoD
                                        self.telefono.text = telefonoD
                                        self.direccion.text = direccionD
                                    self.nombreS = nombreD
                                    self.correoS = correoD
                                    self.direccionS = direccionD
                                    self.telefonoS = telefonoD
                                }
                                    
                                
                                
                                    
                                    
                                    
                                    
                        }
                        
                                
                                
                            
                        }
                        
                    }
                }
        }
        
    }

}
