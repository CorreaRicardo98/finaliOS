//
//  EstablecimientoTableViewCell.swift
//  FinalProject
//
//  Created by Mac17 on 01/07/21.
//

import UIKit

class EstablecimientoTableViewCell: UITableViewCell {
    @IBOutlet weak var Nombre: UILabel!
    
    @IBOutlet weak var Telefono: UILabel!
    @IBOutlet weak var Correo: UILabel!
    @IBOutlet weak var Direccion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
