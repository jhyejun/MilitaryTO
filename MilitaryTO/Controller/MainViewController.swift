//
//  MainViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 4. 3..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let objects = realm.objects(TOData.self)
    var objectsArray = [TOData]()
    var shownObjects = [TOData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if objects.isEmpty {
            convert()
        }
        
        else {
            for object in objects {
                self.objectsArray.append(object)
                self.shownObjects.append(object)
            }
        }
        
        self.tableView.reloadData()
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shownObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SearchTableViewCell", owner: self, options: nil)?.first as! SearchTableViewCell
        let object = self.shownObjects[indexPath.row]
        
        cell.selectionStyle = .none
        cell.name.text = object.name
        cell.toTotal.text = object.total != "" ? object.total : "0"
        
        return cell
    }
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.shownObjects = self.objectsArray
            self.tableView.reloadData()
            return
        }
        
        self.shownObjects = objectsArray.filter {
            $0.name.contains(searchText)
        }
        
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
}
