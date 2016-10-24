//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    
    var businesses = [Business]()
    var inititalBusinesses = [Business]()
    
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchBar.placeholder = "Restaurants"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        Business.search(withTerm: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                if let results = businesses {
                    self.inititalBusinesses.removeAll()
                    self.inititalBusinesses.append(contentsOf: results)
                    self.businesses.removeAll()
                    self.businesses.append(contentsOf: results)
                    self.tableView.reloadData()
                }
            }
        )
    }
}

extension BusinessesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "StackedBusinessCell", for: indexPath) as! BusinessCell
        
        let business = businesses[indexPath.row]
        cell.update(withBusiness: business)
        return cell
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        businesses.removeAll()
        tableView.reloadSections(IndexSet(integer:0), with: .automatic)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        
        businesses.removeAll()
        businesses.append(contentsOf: inititalBusinesses)
        tableView.reloadSections(IndexSet(integer:0), with: .automatic)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        Business.search(withTerm: searchText, sort: .distance, categories: nil, deals: nil) { (results: [Business]?, error: Error?) in
            self.businesses.removeAll()
            if let res = results {
                self.businesses.append(contentsOf: res)
            }
            self.tableView.reloadData()
        }
    }

}
