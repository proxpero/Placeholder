//
//  Model+Routing.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/19/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

private let scheme = "https"
private let host = "jsonplaceholder.typicode.com"

enum Route: String {

    case users
    case albums
    case photos
    case posts
    case comments
    case todos

    private static var baseURL: URL {
        guard let result = URL(string: scheme + "://" + host) else {
            fatalError("Could not create base url from scheme: \(scheme) and host: \(host)")
        }
        return result
    }

    var all: URL {
        return Route.baseURL.appendingPathComponent(self.endpoint)
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
