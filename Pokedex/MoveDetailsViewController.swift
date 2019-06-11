//
//  MoveDetailsViewController.swift
//  Pokedex
//
//  Created by Gunther Ribak on 11/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveDetailsViewController: UIViewController {
    
    let requestMaker = RequestMaker(baseUrl: "https://pokeapi.co/api/v2/")
    
    @IBOutlet weak var backgroundView: GradientView!
    @IBOutlet weak var iconBigView: UIView!
    @IBOutlet weak var iconBig: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var iconSmall: UIImageView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var effect: UILabel!
    @IBOutlet weak var basePowerLabel: UILabel!
    @IBOutlet weak var basePower: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    @IBOutlet weak var pp: UILabel!
    
    var move: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let move = self.move {
            self.fetchData(for: move)
        }
    }
    
    func configDetails(moveDetails: MoveDetails) {
        let pokemonType = moveDetails.type.name
        if let color = pokemonType.color {
            backgroundView.startColor = color
            backgroundView.endColor = color
        }
        iconBigView.backgroundColor = pokemonType.color
        iconBig.image = pokemonType.icon
        name.text = moveDetails.name
        iconSmall.image = pokemonType.icon
        typeView.backgroundColor = pokemonType.color
        type.text = moveDetails.type.name.rawValue.uppercased()
        if moveDetails.effectEntries.count > 0 {
            effect.text = moveDetails.effectEntries[0].effect
        } else {
            effect.text = "N/D"
        }
        basePowerLabel.textColor = pokemonType.color
        basePower.text = moveDetails.power.description
        accuracyLabel.textColor = pokemonType.color
        accuracy.text = "\(moveDetails.accuracy.description)%"
        ppLabel.textColor = pokemonType.color
        pp.text = moveDetails.pp.description
    }
    
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension MoveDetailsViewController {
    
    func fetchData(for moveName: String) {
        requestMaker.make(withEndpoint: .move(query: moveName)) { (moveDetails: MoveDetails) in
            DispatchQueue.main.async {
                self.configDetails(moveDetails: moveDetails)
            }
        }
    }
}
