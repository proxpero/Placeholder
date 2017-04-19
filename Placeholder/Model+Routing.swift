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

    private var baseURL: URL {
        guard let result = URL(string: scheme + "://" + host) else {
            fatalError("Could not create base url from scheme: \(scheme) and host: \(host)")
        }
        return result
    }

    case users
    case albums
    case photos
    case posts
    case comments
    case todos

    var endpoint: String {
        return self.rawValue
    }

    func path(withId id: Int) -> String {
        return endpoint + "/\(id)"
    }

    var all: URL {
        return baseURL.appendingPathComponent(endpoint)
    }

    func url(withId id: Int) -> URL {
        return baseURL.appendingPathComponent(path(withId: id))
    }

}

extension URL {
    func appending(_ routeEndpoint: Route) -> URL {
        return self.appendingPathComponent(routeEndpoint.endpoint)
    }
}
