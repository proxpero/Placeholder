//
//  Model+Routing.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/19/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

enum Route: String {

    static var urlProvider: URLProvider?

    case users
    case albums
    case photos
    case posts
    case comments
    case todos

    var all: URL {
        guard let urlProvider = Route.urlProvider else {
            fatalError("No url provider")
        }
        return urlProvider.baseURL.appendingPathComponent(self.endpoint)
    }

    subscript(id: Int) -> URL {
        return all.appendingPathComponent("\(id)")
    }

    var endpoint: String {
        return self.rawValue
    }

}

extension URL {

    subscript(endpoint: Route) -> URL {
        return self.appendingPathComponent(endpoint.rawValue)
    }

    subscript(id: Int) -> URL {
        return self.appendingPathComponent("\(id)")
    }
}
