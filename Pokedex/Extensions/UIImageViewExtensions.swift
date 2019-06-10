//
//  UIImageViewExtensions.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit
import Nuke

extension UIImage {
    
    static let pikachu = UIImage(named: "pikashadow")!
    
}

extension UIImageView {
    
    func loadImage(from urlString: String) {
        if let url = URL(string: urlString) {
            //Simples -> Nuke.loadImage(with: url, into: self)
            let options = ImageLoadingOptions(placeholder: .pikachu, transition: .fadeIn(duration: 0.3), failureImage: .pikachu)
            Nuke.loadImage(with: url, options: options, into: self)
        }
    }
}
