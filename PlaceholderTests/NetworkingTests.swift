//
//  NetworkingTests.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/24/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import XCTest
@testable import Placeholder

class NetworkingTests: XCTestCase {

    func sampleURL(with filename: String, ext: String = "txt") -> URL {
        guard let url = Bundle(for: NetworkingTests.self).url(forResource: filename, withExtension: ext) else {
            XCTFail("Could not generate URL from \(filename)")
            fatalError()
        }
        return url
    }

    func testResourceParseData() {

        let expectation = "This is sample text."
        let utf8 = expectation.data(using: .utf8)!

        let url = sampleURL(with: "sampleText", ext: "txt")
        let method = HttpMethod<Data>.get
        func parseData(data: Data?) -> String {
            guard let data = data, let result = String(data: data, encoding: .utf8) else { XCTFail(); fatalError() }
            return result
        }

        let resource = Resource<String>(
            url: url,
            method: method,
            parse: parseData
        )

        let result = resource.parse(utf8)

        XCTAssertNotNil(result)
        XCTAssertEqual(expectation, result)

    }

    func testResourceParseJSON() {

        struct Sample: JSONDecodable {
            let foo: String
            let bar: Int

            init(foo: String, bar: Int) {
                self.foo = foo
                self.bar = bar
            }

            init?(json: JSONDictionary) {
                guard
                    let foo = json["foo"] as? String,
                    let bar = json["bar"] as? Int
                    else { return nil }
                self.foo = foo
                self.bar = bar
            }

            static func ==(lhs: Sample, rhs: Sample) -> Bool {
                return lhs.foo == rhs.foo && lhs.bar == rhs.bar
            }

        }

        let foo = "This is a sample."
        let bar = 42
        let expectation = Sample(foo: foo, bar: bar)

        let sampleJSON = "{\"foo\": \"\(foo)\", \"bar\": \(bar) }"
        let jsonData = sampleJSON.data(using: .utf8)!

        let url = sampleURL(with: "dummyFile", ext: "json")
        let method = HttpMethod<Any>.get
        func parseJSON(json: Any) -> Sample? {
            guard let dict = json as? JSONDictionary else {
                XCTFail(); fatalError()
            }
            print(dict)
            guard let result = Sample(json: dict) else {
                XCTFail(); fatalError()
            }
            return result
        }

        let resource = Resource<Sample>(
            url: url,
            method: method,
            parseJSON: parseJSON
        )

        let result = resource.parse(jsonData)
        XCTAssertNotNil(result)
        XCTAssertEqual("This is a sample.", result!.foo)
        XCTAssertEqual(42, result!.bar)

    }
}
