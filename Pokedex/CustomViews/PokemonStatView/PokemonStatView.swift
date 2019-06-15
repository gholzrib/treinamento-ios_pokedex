//
//  PokemonStatView.swift
//  Pokedex
//
//  Created by Gunther Ribak on 13/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonStatView: UIView {

    let nibName = "PokemonStatView"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
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
    
    func config(pokemonStat: PokemonStats) {
        self.nameLabel.text = pokemonStat.name
        self.valueLabel.text = String.init(format: "%03d", pokemonStat.value)
        self.progressView.progress = Float(pokemonStat.value)/Float(100)
    }

}
