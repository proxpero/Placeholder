//
//  Resource.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

/// A representation of a resource on the internet.
public struct Resource<A> {

    /// The URL of the resource.
    public let url: URL

    /// The HTTPMethod ('get', 'post', etc.)
    public let method: HttpMethod<Data>

    /// A function to convert the received data to an `A`.
    public let parse: (Data) -> A?

}

extension Resource {

    /// Initialize a `Resource` specifically expecting JSON
    init(url: URL, method: HttpMethod<Any> = .get, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method.map { json in
            // If `json` cannot be transformed into `Data` then it is a programmer
            // error and the app will crash. Check that the json was formed correctly.
            let result = try! JSONSerialization.data(withJSONObject: json, options: [])
            return result
        }
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
    
}
