//
//  DataController.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/18/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation


protocol IDataSource {
    associatedtype DataItemType
    var numberOfSection: Int { get }
    func numberOfItem(inSection: Int) -> Int
    func data(atIndex: IndexPath) -> DataItemType
}


protocol DataControllerDelegate: class {
    func dataControllerDidChangeContent<T>(_ dataController: DataController<T>)
}

class DataController<T> {

    public weak var delegate: DataControllerDelegate?
    fileprivate var  items:[[T]]

    init(items:[[T]]){
        self.items = items
    }

    func set(items:[[T]]){
        self.items = items
        self.delegate?.dataControllerDidChangeContent(self)
    }

    func item(atIndexPath indexPath: IndexPath) -> T{
        return self.items[indexPath.section][indexPath.item]
    }

    func numberOfItems(inSection section: Int) -> Int{
        return items[section].count
    }
}

extension IndexPath {
    public func toDataSourceIndexPath() -> IndexPath {
        return IndexPath(item: self.row, section: self.section)
    }
}
