//
//  CountriesListViewModel.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/15/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

fileprivate extension CountryResponse {
    var flagImageUri: String {
        get {
            return "https://www.countryflags.io/\(self.id)/shiny/64.png"
        }
    }
    func convertToCountryInfo() -> CountryInfo {
        return CountryInfo(name: self.name, imageUri: flagImageUri, availableProducts:self.products.map({ (product) -> CountryInfo.Product in
            return product.converToProduct()
        }))
    }
}

fileprivate extension CountryResponse.Product {
    func converToProduct() -> CountryInfo.Product {
        return CountryInfo.Product(name: self.name.uppercased(), backgroundColor: UIColor(hex: self.color), textColor: UIColor.white)
    }
}

class CountriesListViewModel: ICountriesListViewModel {
    public let data: DataController<CountryInfo>

    private let apiLoader: APIRequestLoader<CountriesRequest>
    private var countriesList: [CountryResponse]{
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
            self.countriesList = countries.sorted(by: { (lhs, rhs) -> Bool in
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
        var items = self.countriesList
        if let filter = self.filter,
                filter.count > 0 {
            let filterBlock: (CountryResponse) -> Bool = { (viewModel) -> Bool in
                viewModel.name.lowercased().contains(filter.lowercased())
            }

            items = items.filter(filterBlock)
        }

        self.data.set(sections: [items.map({ (country) -> CountryInfo in
            return country.convertToCountryInfo()
        })])
    }
}

