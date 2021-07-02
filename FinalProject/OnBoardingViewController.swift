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
    
    var paginaActual = 0{
        didSet{
            if paginaActual == diapos.count - 1 {
                botonSiguiente.setTitle("Comenzar", for: .normal)
            }else{
                botonSiguiente.setTitle("Siguiente", for: .normal)
            }
        }
    }
    var diapos: [OnBoardingDiapositiva] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diapos = [
            OnBoardingDiapositiva(titulo: "Busque", descripcion: "Busque entre nuestra lista alun estableciemiento que necesite", image: #imageLiteral(resourceName: "fondo1")),
            OnBoardingDiapositiva(titulo: "Registrate", descripcion: "Pon tu negocio con nosotros", image: #imageLiteral(resourceName: "fondo2")),
            OnBoardingDiapositiva(titulo: "Actualizate", descripcion: "Obten las mejores noticias en nuestra seccion de noticias", image: #imageLiteral(resourceName: "fondo1"))
            
        ]
        CollectionViewOn.delegate = self
        CollectionViewOn.dataSource = self
        
        let defaults = UserDefaults.standard
        if let abierto = defaults.value(forKey: "abierto") {
            print(abierto)
            navigateToHome()
            
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    func navigateToHome(){
        let vc = storyboard?.instantiateViewController(identifier: "HOME") as! UIViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        
        present(vc, animated: true, completion: nil)
    }
    

    @IBAction func siguiente(_ sender: Any) {
        if paginaActual == diapos.count - 1 {
            let defaults = UserDefaults.standard
            defaults.set("listo",forKey: "abierto")
            navigateToHome()
            
        }else{
            paginaActual += 1
            let indice = IndexPath(item: paginaActual, section: 0)
            CollectionViewOn.scrollToItem(at: indice, at: .centeredHorizontally, animated: true)
        }
        
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

extension OnBoardingViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
	
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let ancho = scrollView.frame.width
        paginaActual = Int(scrollView.contentOffset.x/ancho)
        panelControl.currentPage = paginaActual
    }
}

