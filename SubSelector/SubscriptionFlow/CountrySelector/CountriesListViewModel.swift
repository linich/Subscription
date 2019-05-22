//
//  CountriesListViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

fileprivate extension Country {
    func convertToCountryInfo() -> CountryInfo {
        return CountryInfo(name: self.name, image: nil, availableProducts:self.products.map({ (product) -> CountryInfo.Product in
            return product.converToProduct()
        }))
    }
}

fileprivate extension Country.Product {
    func converToProduct() -> CountryInfo.Product {
        return CountryInfo.Product(name: self.name.uppercased(), backgroundColor: UIColor(hex: self.color), textColor: UIColor.white)
    }
}

class CountriesListViewModel: ICountriesListViewModel {
    public let data: DataController<CountryInfo>

    private let apiLoader: APIRequestLoader<CountriesRequest>

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

    init(urlSession: URLSession = .shared) {
        self.apiLoader = APIRequestLoader(apiRequest: CountriesRequest(), urlSession: urlSession)
        self.data = DataController(sections: [])
        self.countriesList = []
    }

    func loadData(){
        self.apiLoader.loadAPIRequest(requestData: CountryRequestData()) { (countries, error) in
            guard let countries = countries else { return}
            self.countriesList = countries.map({ (country) -> CountryInfo in
                return country.convertToCountryInfo()
            }).sorted(by: { (lhs, rhs) -> Bool in
                return lhs.name < rhs.name
            })
        }
    }

    func countryId(atIndexPath: IndexPath) -> String {
        return "country_id"
    }

    func filterItems(filter: String?) {
        self.filter = filter
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

