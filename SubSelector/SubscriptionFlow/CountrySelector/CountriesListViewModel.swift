//
//  CountriesListViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

class CountriesListViewModel: ICountriesListViewModel {
    public let data: DataController<CountryInfo>

    private let productService: IProductService

    private var countriesList: [CountryInfo]{
        didSet {
            self.updateSections()
        }
    }

    private var filter: String? {
        didSet(newValue) {
            if newValue == self.filter {
                return
            }
            self.updateSections()
        }
    }

    init(productService: IProductService) {
        self.productService = productService
        self.data = DataController(sections: [])
        self.countriesList = []
    }

    func loadData(){
        self.productService.loadCountries { [weak self](countries) in
            self?.loadCountriesCompleleted(countries: countries)
        }
    }

    func countryId(atIndexPath: IndexPath) -> String {
        return "country_id"
    }

    func filterItems(filter: String?) {
        self.filter = filter
    }

    fileprivate func loadCountriesCompleleted(countries: [ICountryInfo]) {
        let models = countries.map { (countryInfo) -> CountryInfo in
            let features = countryInfo.availableProducts.map({ (product) -> CountryInfo.Product in
                return CountryInfo.Product(name: product.name.uppercased(),
                                                     backgroundColor: product.color,
                                                     textColor: UIColor.white)
            })
            return CountryInfo(name: countryInfo.name, image: UIImage(named: countryInfo.id), availableProducts: features)
        }
        self.countriesList = models
    }

    fileprivate func updateSections() {
        guard let filter = self.filter,
                filter.count > 0 else {
            self.data.set(sections: [self.countriesList])
            return
        }

        let filterBlock: (CountryInfo) -> Bool = { (viewModel) -> Bool in
            viewModel.name.lowercased().contains(filter.lowercased())
        }

        let items = [countriesList.filter(filterBlock)]

        self.data.set(sections: items)
    }
}

