//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var primaryTypeView: UIView!
    @IBOutlet weak var primaryTypeImageView: UIImageView!
    @IBOutlet weak var secondaryTypeView: UIView!
    @IBOutlet weak var secondaryTypeImageView: UIImageView!
    
    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        nameLabel.text = model.name.capitalized
        if let id = Int(model.id) {
            idLabel.text = String.init(format: "#%03d", id)
        }
        primaryTypeView.backgroundColor = model.types.first?.color
        primaryTypeImageView.image = model.types.first?.icon
        if model.types.count > 1 {
            secondaryTypeView.isHidden = false
            secondaryTypeView.backgroundColor = model.types[1].color
            secondaryTypeImageView.image = model.types[1].icon
        } else {
            secondaryTypeView.isHidden = true
        }
    }

}
