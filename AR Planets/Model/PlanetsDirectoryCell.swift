//
//  PlanetsDirectoryCell.swift
//  AR Planets
//
//  Created by Jakub Perich on 06/01/2019.
//  Copyright © 2019 Jakub Perich. All rights reserved.
//

import UIKit

class PlanetsDirectoryCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = 10

    }

    func setupPlanetCell(planet: String) {
        
        cellImage.image = UIImage(named: planet)
        cellLbl.text = planet.capitalized
        
    }
    
   
}
