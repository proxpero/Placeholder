//
//  Resource.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import Foundation

public struct Resource<A> {
    public let url: URL
    public let method: HttpMethod<Data>
    public let parse: (Data) -> A?
}

extension Resource {

    /// Initialize a `Resource` specifically expecting JSON
    init(url: URL, method: HttpMethod<Any> = .get, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method.map { json in
            try! JSONSerialization.data(withJSONObject: json, options: [])
        }
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
    
}
