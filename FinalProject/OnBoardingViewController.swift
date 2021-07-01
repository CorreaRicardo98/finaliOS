//
//  OnBoardingViewController.swift
//  FinalProject
//
//  Created by Mac17 on 25/06/21.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var CollectionViewOn: UICollectionView!
    
    @IBOutlet weak var botonSiguiente: UIButton!
    @IBOutlet weak var panelControl: UIPageControl!
    var diapos: [OnBoardingDiapositiva] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        diapos = [
            OnBoardingDiapositiva(titulo: "Titulo Diapositiva 1", descripcion: "Descripcion Diapositiva 1", image: #imageLiteral(resourceName: "fondo1")),
            OnBoardingDiapositiva(titulo: "Titulo Diapositiva 2", descripcion: "Descripcion Diapositiva 2", image: #imageLiteral(resourceName: "fondo2")),
            OnBoardingDiapositiva(titulo: "Titulo Diapositiva 3", descripcion: "Descripcion Diapositiva 3", image: #imageLiteral(resourceName: "fondo1")),
            OnBoardingDiapositiva(titulo: "Titulo Diapositiva 4", descripcion: "Descripcion Diapositiva 4", image: #imageLiteral(resourceName: "fondo2"))
            
        ]
        CollectionViewOn.delegate = self
        CollectionViewOn.dataSource = self

        
    }
    

    @IBAction func siguiente(_ sender: Any) {
    }
    

}

extension OnBoardingViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diapos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewOn.dequeueReusableCell(withReuseIdentifier: "celdaColection", for: indexPath) as! OnBoardingCollectionViewCell
        cell.configurar(diapositiva: diapos[indexPath.row])
        return cell
    }
    
    
}

