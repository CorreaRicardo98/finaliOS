//
//  EstablecimientosViewController.swift
//  FinalProject
//
//  Created by Mac17 on 21/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore

struct Establecimiento {
    let nombre:String
    let correo:String
    let direccion:String
    let telefono:String
}

class EstablecimientosViewController: UIViewController {
    var establecimientos = [Establecimiento]()
    var dir:String!
    var name:String!
    @IBOutlet weak var tablaEstablecimientos: UITableView!
    var idCategoria:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaEstablecimientos.register(UINib(nibName: "EstablecimientoTableViewCell", bundle: nil), forCellReuseIdentifier: "tbcell")
        carar()
    }
    
    func carar(){
        let db = Firestore.firestore()
        db.collection("neocios")
            .whereField("tipo", isEqualTo: idCategoria!)
            .getDocuments { (querySnapShot, error) in
                if let err = error{
                    print("error con los datos: \(err.localizedDescription)")
                }else{
                    if let snapshot = querySnapShot?.documents{
                        for document in snapshot {
                            print(document.documentID)
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
                            
                            let estable = Establecimiento(nombre: nombreD, correo: correoD, direccion: direccionD, telefono: telefonoD)
                            
                            self.establecimientos.append(estable)
                            
                        }
                        print(self.establecimientos.count)
                        self.tablaEstablecimientos.reloadData()
                    }
                }
                
        }
    }

}

extension EstablecimientosViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.establecimientos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaEstablecimientos.dequeueReusableCell(withIdentifier: "tbcell",for: indexPath) as! EstablecimientoTableViewCell
        cell.Nombre.text = establecimientos[indexPath.row].nombre
        cell.Correo.text = establecimientos[indexPath.row].correo
        cell.Telefono.text = establecimientos[indexPath.row].telefono
        cell.Direccion.text = establecimientos[indexPath.row].direccion
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dir = establecimientos[indexPath.row].direccion
        self.name = establecimientos[indexPath.row].nombre
        performSegue(withIdentifier: "viewMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewMap"
        {
            let vc = segue.destination as! MapaViewController
            vc.ubicacion = self.dir
            vc.nombre = self.name
        }
    }
    
    
}
