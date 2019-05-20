//
//  CountryListViewController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/16/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

protocol CountryListViewControllerDelegate: NSObjectProtocol {
    func countryListViewController(countryListViewController: CountriesListViewController, didSelectCountryWithId: String) -> Void
}

class CountriesListViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, DataControllerDelegate {
    public var onCountrySelected: ((CountriesListViewController, String) ->())?
    public var viewModel: ICountriesListViewModel?
    public var countryListTableViewDataSource: CountriesListTableViewDataSource?
    public weak var delegate: CountryListViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!

    fileprivate func setupDataSource() {
        if let viewModel = self.viewModel {
            viewModel.data.delegate = self
            viewModel.loadData()
            self.countryListTableViewDataSource = CountriesListTableViewDataSource(data: viewModel.data)
            self.countryListTableViewDataSource?.attach(toTableView: tableView)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.filterItems(filter: searchText)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewModel = self.viewModel  {
            self.delegate?.countryListViewController(countryListViewController: self,
                                                     didSelectCountryWithId: viewModel.countryId(atIndexPath: indexPath))
        }
    }

    func dataControllerDidChangeContent<SubscriptionViewModel>(_ dataController: DataController<SubscriptionViewModel>) {
        self.tableView.reloadData()
    }
}
