//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension DetailViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 48
        }
        return 0
    }
    
}
