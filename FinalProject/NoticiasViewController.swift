//
//  NoticiasViewController.swift
//  FinalProject
//
//  Created by Mac17 on 21/06/21.
//

import UIKit

struct MyNoticia:Codable {
    let title:String
    let description:String
}

struct MyData:Codable{
    let data:[MyNoticia]
}

class NoticiasViewController: UIViewController {

    @IBOutlet weak var buscarTF: UITextField!
    @IBOutlet weak var tableData: UITableView!
    
    var noticias = [MyNoticia]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func buscarButton(_ sender: Any) {
        if let busqueda = buscarTF.text, busqueda != ""	{
            let urlString = "http://api.mediastack.com/v1/news?access_key=57ede615da33992a413940deec391c7d&%20languages=es&keywords=\(busqueda.replacingOccurrences(of:" ", with: "%20"))"
            
            if let url = URL(string: urlString){
                if let data = try? Data(contentsOf:url){
                    
                    parse(json:data)
                }
            }
        }else{
            let alerta = UIAlertController(title: "Aviso", message: "Usted debe escribir algo en la caja de texto", preferredStyle: .actionSheet)
            let accionAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alerta.addAction(accionAceptar)
            present(alerta, animated: true, completion: nil)
        }
        
        
        
        
        
    }
    
    func parse(json:Data){
        let decoder = JSONDecoder()
        
        if let jsonPeticion = try? decoder.decode(MyData.self, from: json){
            self.noticias = jsonPeticion.data
            tableData.reloadData()
        }
    }


}

extension NoticiasViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = tableData.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cel.textLabel?.text = noticias[indexPath.row].title
        cel.detailTextLabel?.text = noticias[indexPath.row].description
        
        return cel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    
    
}
