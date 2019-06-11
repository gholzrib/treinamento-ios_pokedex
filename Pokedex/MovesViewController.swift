//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MovesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let requestMaker = RequestMaker()
    private var moves = [Move]()
    var move: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTable()
        self.fetchData()
    }
    
    private func configTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MoveDetailsViewController {
            destination.move = self.move
        }
    }

}

extension MovesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "move", for: indexPath)
        if let moveCell = cell as? MoveTableViewCell {
            moveCell.config(with: moves[indexPath.row])
        }
        return cell
    }
    
    
}

extension MovesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.move = self.moves[indexPath.row].name
        self.performSegue(withIdentifier: "show-move-details", sender: nil)
    }
}

extension MovesViewController {
    func fetchData() {
        requestMaker.make(withEndpoint: .moves) { (moves: [Move]) in
            self.moves = moves
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
