//
//  CountryListViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation
import StoreKit

class CountriesListViewModel: ICountryListViewModel {
    public let data: DataController<SubscriptionViewModel>

    private let productService: IProductListService

    private var countriesList: [SubscriptionViewModel]{
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

    init(productService: IProductListService) {
        self.productService = productService
        self.data = DataController(sections: [])
        self.countriesList = []
    }

    public func loadData(){
        self.productService.loadCountries { [weak self](countries) in
            self?.loadCountriesCompleleted(countries: countries)
        }
    }

    func countryId(atIndexPath: IndexPath) -> String {
        return "country_id"
    }

    fileprivate func loadCountriesCompleleted(countries: [ICountryInfo]) {
        let models = countries.map { (countryInfo) -> SubscriptionViewModel in
            let features = countryInfo.availableProducts.map({ (product) -> SubscriptionViewModel.Feature in
                return SubscriptionViewModel.Feature(name: product.name.uppercased(),
                                                     backgroundColor: product.color,
                                                     textColor: UIColor.white)
            })
            return SubscriptionViewModel(localizedName: countryInfo.name, image: UIImage(named: countryInfo.id), features: features)
        }
        self.countriesList = models
    }

    public func filterItems(filter: String?) {
        self.filter = filter
    }

    fileprivate func updateSections() {
        guard let filter = self.filter else {
            self.data.set(sections: [self.countriesList])
            return
        }

        let filterBlock: (SubscriptionViewModel) -> Bool = { (viewModel) -> Bool in
            viewModel.localizedName.lowercased().contains(filter.lowercased())
        }

        let items =  filter.count > 0 ? [countriesList.filter(filterBlock)] : [countriesList]

        self.data.set(sections: items)
    }
}

