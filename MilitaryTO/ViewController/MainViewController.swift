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
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        if objects.isEmpty {
            convert(result: { result in
                self.setTableData()
            })
        }
            
        else {
            self.setTableData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetailViewController" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let viewController = segue.destination as! DetailViewController
                
                viewController.sector = shownObjects[indexPath.row].sector
                viewController.scale = shownObjects[indexPath.row].scale
                viewController.name = shownObjects[indexPath.row].name
                viewController.address = shownObjects[indexPath.row].address
                viewController.tel = shownObjects[indexPath.row].tel
                viewController.mainProduct = shownObjects[indexPath.row].mainProduct
                viewController.selectionYear = shownObjects[indexPath.row].selectionYear
                viewController.total = shownObjects[indexPath.row].total
                viewController.before98Three = shownObjects[indexPath.row].before98Three
                viewController.before98Two = shownObjects[indexPath.row].before98Two
                viewController.at99Three = shownObjects[indexPath.row].at99Three
                viewController.reason = shownObjects[indexPath.row].reason
                viewController.local = shownObjects[indexPath.row].local
            }
        }
    }
    
    func setTableData() {
        for object in objects {
            self.objectsArray.append(object)
            self.shownObjects.append(object)
        }
        
        self.tableView.reloadData()
    }
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goDetailViewController", sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.tableView.isDecelerating {
            self.view.endEditing(true)
        }
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}
