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
    fileprivate var  sections:[[T]]

    init(sections:[[T]]){
        self.sections = sections
    }

    func set(sections:[[T]]){
        self.sections = sections
        self.delegate?.dataControllerDidChangeContent(self)
    }

    func item(atIndexPath indexPath: IndexPath) -> T{
        return self.sections[indexPath.section][indexPath.item]
    }

    func numberOfItems(inSection section: Int) -> Int{
        return sections[section].count
    }
    
    var numberOfSections: Int {
        get {
            return self.sections.count
        }
    }
}

extension IndexPath {
    public func toDataSourceIndexPath() -> IndexPath {
        return IndexPath(item: self.row, section: self.section)
    }
}
