//
//  MoveTableViewCell.swift
//  Pokedex
//
//  Created by Gunther Ribak on 10/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var typeImageView: UIImageView!

    func config(with model: Move) {
        name.text = model.name.capitalized
        typeView.backgroundColor = model.type.color
        typeImageView.image = model.type.icon
    }

}
