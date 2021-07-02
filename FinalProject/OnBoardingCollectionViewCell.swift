//
//  OnBoardingCollectionViewCell.swift
//  FinalProject
//
//  Created by Mac17 on 25/06/21.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    		
    @IBOutlet weak var imagenDiapo: UIImageView!
    @IBOutlet weak var tituloDiapo: UILabel!
    
    @IBOutlet weak var descripcionDiapo: UILabel!
    
    func configurar(diapositiva:OnBoardingDiapositiva){
        imagenDiapo.image = diapositiva.image
        tituloDiapo.text = diapositiva.titulo
        descripcionDiapo.text = diapositiva.descripcion
    }
}

