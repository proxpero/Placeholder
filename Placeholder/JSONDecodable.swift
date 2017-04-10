//
//  JSONDecodable.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

/// A JSON dictionary.
public typealias JSONDictionary = [String: AnyObject]

/// Describes a type that can create itself out of a JSON dictionary.
protocol JSONDecodable {

    /// Initialize `Self` with a JSON dictionary.
    init?(json: JSONDictionary)

}

