//
//  CountryListViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/16/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    // onCountrySelected - the first parameter is the controller itself, the second id of the country.
    public var onCountrySelected: ((CountryListViewController, String) ->())?
    public var viewModel: CountryListViewModel?
    public var countryListTableViewDataSource: CountryListTableViewDataSource?
    
    @IBOutlet weak var tableView: UITableView!

    fileprivate func setupViewModelAndDataSource() {
        if let viewModel = self.viewModel {
            viewModel.onItemsChanged = {[weak self] () in self?.tableView.reloadData() }
            self.countryListTableViewDataSource = CountryListTableViewDataSource(tableView: self.tableView, viewModel: viewModel)
            self.countryListTableViewDataSource?.setup()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelAndDataSource()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.filterItems(filter: searchText)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewModel = self.viewModel  {
            self.onCountrySelected?(self, viewModel.countryId(atIndex: indexPath.row))
        }
    }
}
