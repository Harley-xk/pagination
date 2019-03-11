//
//  Paginatable.swift
//  Pagination
//
//  Created by Anthony Castelli on 4/5/18.
//

import Foundation
import Fluent
import Vapor

/// Make a model paginatable.
public protocol Paginatable: Model {

    static var defaultPageSize: Int { get }
    static var maxPageSize: Int? { get }
    static var defaultPageSorts: [Self.Database.QuerySort] { get }

}

// MARK: - Defualts


extension KeyPath where Root: Model {

    public func querySort(_ direction: Root.Database.QuerySortDirection = Root.Database.querySortDirectionDescending) -> Root.Database.QuerySort {
        return Root.Database.querySort(self.queryField, direction)
    }
    
    public var fluentProperty: FluentProperty {
        return FluentProperty.keyPath(self)
    }
    
    public var queryField: Root.Database.QueryField {
        return Root.Database.queryField(fluentProperty)
    }

}
