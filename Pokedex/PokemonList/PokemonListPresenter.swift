//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Gunther Ribak on 15/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListPresenter: NSObject {
    
    weak var view: PokemonListViewType?
    
    private lazy var interactor: PokemonListInteractorInput = PokemonListInteractor(output: self)
    
    private var pokemonList = [Pokemon]()
    
    private let idsKey = "favorites.ids"
    
    override init() {
        if let data = UserDefaults.standard.array(forKey: idsKey) as? [String] {
            self.favoriteIds = Set(data)
        } else {
            self.favoriteIds = []
        }
        super.init()
    }
    
    private var favoriteIds: Set<String> {
        didSet {
            print(favoriteIds)
            UserDefaults.standard.set(Array(favoriteIds), forKey: idsKey)
        }
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return pokemonList[index]
    }
    
    func swipe(at index: Int) {
        let pokemonId = self.pokemon(at: index).id
        guard self.favoriteIds.contains(pokemonId) else {
            self.favoriteIds.insert(pokemonId)
            return
        }
        self.favoriteIds.remove(pokemonId)
    }
    
    func swipeAction(for index: Int) -> PokemonSwipeAction {
        return self.favoriteIds.contains(self.pokemon(at: index).id)
            ? .removeFavorite
            : .addFavorite
    }
}

extension PokemonListPresenter : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath)
        
        if let pokemonCell = cell as? PokemonTableViewCell {
            pokemonCell.config(with: pokemonList[indexPath.row])
        }
        
        return cell
    }
    
}

extension PokemonListPresenter {
    
    func fetchData() {
        self.interactor.fetchData()
    }
}

extension PokemonListPresenter: PokemonListInteractorOutput {
    func dataFetched(_ data: PokemonList) {
        self.pokemonList = data.pokemons
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
}
