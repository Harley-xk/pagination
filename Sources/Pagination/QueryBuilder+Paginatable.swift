//
//  QueryBuilder+Paginatable.swift
//  Pagination
//
//  Created by Anthony Castelli on 4/5/18.
//

import Foundation
import Fluent
import Vapor

extension QueryBuilder where Result: Paginatable & Content, Result.Database == Database {

    /// Returns a custom page-based response using page number from the request data.
    public func paginate<T>(for req: Request, response type: T.Type) throws -> Future<T> where T: PaginatedResponse, T.DataType == Result {
        return try self.page(for: req).map(to: type) { type.init(from: $0) }
    }

    /// Returns a custom page-based response using page number from the request data using a transformtion closure.
    public func paginate<R, T>(
        on req: Request,
        response type: T.Type,
        _ transformation: @escaping (QueryBuilder<Database, Result>) throws -> Future<[R]>
        ) throws -> Future<T> where T: PaginatedResponse, T.DataType == R {

        return try self.page(for: req, transformation).map(to: type.self) { type.init(from: $0) }
    }

}
