//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet var gradientView: GradientView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokemonImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var pokemonTypeView: PokemonTypeView!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialConfig()
        if let type = pokemon?.types.first {
            self.pokemonTypeView.config(type: type)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPokemonAnimation()
        self.requestPokemon()
    }
    
    func initialConfig() {
        if let pokemon = self.pokemon {
            self.gradientView.startColor = pokemon.types.first?.color ?? .black
            self.gradientView.endColor = pokemon.types.first?.color?.lighter() ?? .white
            self.imageView.loadImage(from: pokemon.image)
        }
    }
    
    func loadPokemonAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options:[.repeat, .autoreverse], animations: {
            self.imageView.alpha = 0.2
        })
//        UIView.animate(withDuration: 1, animations: {
//            self.imageView.alpha = self.imageView.alpha == 1 ? 0.2 : 1
//        }, completion: { _ in
//            self.loadPokemonAnimation()
//        })
    }
    
    func animatePokemonToTop() {
        DispatchQueue.main.async {
            self.imageView.layer.removeAllAnimations()
            self.pokemonImageViewCenterYConstraint.priority = .defaultLow
            self.pokemonImageViewTopConstraint.priority = .defaultHigh
            self.pokemonImageViewHeightConstraint.constant = 80
            self.pokemonImageViewWidthConstraint.constant = 80
            UIView.animate(withDuration: 1, animations: {
                self.imageView.alpha = 1
                self.view.layoutIfNeeded() //Refresh layout for constraints
            })
        }
    }
    
    func requestPokemon() {
        if let pokemon = self.pokemon {
            let requestMaker = RequestMaker()
            requestMaker.make(withEndpoint: .details(query: pokemon.id)) { (pokemon: Pokemon) in
                self.animatePokemonToTop()
            }
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
