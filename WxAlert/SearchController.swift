//
//  SearchController.swift
//  WxAlert
//
//  Created by macbook on 3/20/18.
//  Copyright © 2018 Jaminya. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var resultView: UITableView!
    
    var cityObject = City()
    fileprivate let reuseCellIdentifier = "cityCell"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
   // internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    var filteredList = [String]()
    let emptyArray = [String]()
    var cityList = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hide empty cell in search result
        self.resultView.tableFooterView = UIView()
        
        configureSearchController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Cities"
        resultView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
        
    }
    
    func filterSearchController(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text ?? ""
        self.searchDatabase(searchTerm: searchText)
    }

}


extension SearchController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath)
        let city = searchController.isActive ? filteredList[indexPath.row] : emptyArray[indexPath.row]
        cell.textLabel!.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredList.count :  emptyArray.count
    }
}

// MARK: - Table view delegate

extension SearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "mapSegue" {
            if let indexPath = resultView.indexPathForSelectedRow {
                let selectedCity = cityList[indexPath.row]
                //print("CityList - selectedCity: \(selectedCity)")
                let mapViewController = segue.destination as? MapController
                mapViewController?.cityObject = selectedCity
            }
        }
    }
}


// MARK: - Search delegate

extension SearchController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // Debug
        // print("In updateSearchResults ")
        
        let characterCount = (searchController.searchBar.text?.count)!
        if characterCount >= 3 {
            filterSearchController(searchController.searchBar)
            resultView.reloadData()
        }
    }
    
}

extension SearchController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Debug
        //print("In textDidChange")
        
        if searchText.count == 0 {
            
            // Set search results = emptyArray.count
            searchController.isActive = false
            filteredList.removeAll()
            cityList.removeAll()
        }
        resultView.reloadData()
    }
    
    func searchDatabase(searchTerm: String) {

        filteredList.removeAll()
        cityList.removeAll()
        
        let item = searchTerm
        let dbmgr = DbMgr.sharedInstance
        let dataItem = dbmgr.getSearchList(searchTerm: item)
        
        filteredList = dataItem.filteredList
        cityList = dataItem.cityList
    }
}
