//
//  CategoriaViewController.swift
//  FinalProject
//
//  Created by Mac17 on 21/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore

struct catego {
    let id:String
    let categoria:String
}

class CategoriaViewController: UIViewController {

    var categorias = [catego]()
    var index:Int!
    @IBOutlet weak var tableViweData: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.hidesBackButton	= true
        
        cargarCategorias()

        
    }
    
    func cargarCategorias(){
        let db = Firestore.firestore()
        db.collection("cateorias")
            .order(by: "id")
            .getDocuments { (querySnapShot, error) in
            if let err = error {
                print("Error al cargar datos \(err.localizedDescription)")
            }else{
                if let snappShot = querySnapShot?.documents{
                    for document in snappShot {
                        print("datos => \(document.data())")
                        let datos = document.data()
                        guard let id = datos["id"] as? String else {
                            return
                        }
                        guard let categoria = datos["categoria"] as? String else {
                            return
                        }
                        let cate = catego(id: id, categoria: categoria)
                        self.categorias.append(cate)
                        
                        
                    }
                    self.tableViweData.reloadData()
                    
                }
                
            }
        }
    }

    @IBAction func CerrarSesion(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func salir(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "salirC", sender: self)
        } catch let singnOut as NSError {
            print("Error sinOut: \(singnOut.localizedDescription)")
        }
    }
    
}

extension CategoriaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celldaC", for: indexPath)
        cell.textLabel?.text = categorias[indexPath.row].categoria
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "establecimientos", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "establecimientos"{
            let vc = segue.destination as! EstablecimientosViewController
            
            vc.idCategoria = categorias[self.index].id
        }
    }
    
    
}
