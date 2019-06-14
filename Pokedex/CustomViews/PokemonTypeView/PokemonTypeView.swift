//
//  PokemonTypeView.swift
//  Pokedex
//
//  Created by Gunther Ribak on 12/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonTypeView: UIView {
    
    let nibName = "PokemonTypeView" //nome do xib referenciado
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        self.contentView.fixInView(self)
    }
    
    func config(type: PokemonType) {
        self.typeImageView.image = type.icon
        self.typeLabel.text = type.rawValue.uppercased()
        self.contentView.backgroundColor = type.color
    }
    
}
