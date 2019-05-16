//
//  CountryListTableViewDataSource.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit


class CountryListTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Suggestion", for: indexPath) as? CountryTableViewCell else {
            assert(false, "unknown item")
            return UITableViewCell()
        }
        let viewModel = self.viewModel.itemAt(indexPath.row)
        cell.countryName.textColor = Theme.appTextColor
        cell.countryName.text = viewModel.localizedName
        cell.flagImageView.image = viewModel.image
        cell.productsNames.text = viewModel.features.map({ (feature) -> String in
            feature.name
        }).joined(separator: " ")
        return cell
    }




    let viewModel: CountryListViewModel
    init (tableView: UITableView, viewModel: CountryListViewModel) {
        self.viewModel = viewModel
        super.init()
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Suggestion")
        tableView.dataSource = self
    }
}
