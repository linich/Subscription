//
//  CountryListTableViewDataSource.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

let countryCellId = "CountryCell"
class CountriesListTableViewDataSource: NSObject, UITableViewDataSource {
    private let data: DataController<CountryInfo>
    private let serialQueue = DispatchQueue(label: "Decode queue")
    init (data: DataController<CountryInfo>) {
        self.data = data
        super.init()

    }

    func attach(toTableView tableView: UITableView) {
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: countryCellId)
        tableView.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: countryCellId, for: indexPath) as? CountryTableViewCell else {
            assert(false, "unknown item")
            return UITableViewCell()
        }

        data.item(atIndexPath: indexPath.toDataSourceIndexPath()).setup(cell: cell)
        return cell
    }
}

fileprivate extension CountryInfo.Product {
    fileprivate func setup(_ view: UIView) {
        view.backgroundColor = backgroundColor
        view.set(cornerRadius: Theme.cornerRadius)
        guard let label = view.subviews.last as? UILabel else {
            return
        }

        label.text = name
        label.textColor = textColor
        label.font = Theme.smallFont
        view.sizeToFit()
    }
}

fileprivate extension CountryInfo {

    fileprivate func setupProducts(_ stackView: UIStackView) {
        stackView.spacing = Theme.itemSpacing

        while let last = stackView.arrangedSubviews.last {
            stackView.removeArrangedSubview(last)
            last.removeFromSuperview()
        }

        for feature in availableProducts {
            let view = UIView()
            let label = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(label)
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
            feature.setup(view)
            stackView.addArrangedSubview(view)
        }
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(spacerView)
    }

    func setup(cell: CountryTableViewCell) {
        //Country name
        cell.countryName.textColor = Theme.appTextColor
        cell.countryName.text = name
        cell.countryName.font = Theme.standartFont

        // Flag
        cell.flagImageView.image = nil
        cell.layoutIfNeeded()
        if let url = NSURL(string: imageUri){
            cell.flagImageView.image = UIImage.downloadImage(url: url, to: cell.flagImageView.bounds.size , scale: UIScreen.main.scale)
        }
        cell.flagImageView.set(cornerRadius: Theme.cornerRadius)
        cell.flagImageView.layer.borderWidth = Theme.borderWidth
        cell.flagImageView.layer.borderColor = Theme.borderColor.cgColor

        // Products
        setupProducts(cell.productsStackView)
    }
}
