//
//  PlaceholderTests.swift
//  PlaceholderTests
//
//  Created by Todd Olsen on 4/6/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

import XCTest
@testable import Placeholder

class PlaceholderTests: XCTestCase {

    func sampleURL(with filename: String) -> URL {
        guard let url = Bundle(for: PlaceholderTests.self).url(forResource: filename, withExtension: "json") else {
            XCTFail("Could not generate URL from \(filename)")
            fatalError()
        }
        return url
    }

    func json(with filename: String) -> Any {
        let url = sampleURL(with: filename)
        guard
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
        else {
                XCTFail("Could not set up test.")
                fatalError()
        }
        return json
    }

    func testResource() {
        
    }

    func testParseSingleUserFromJSON() {
        let sample = json(with: "SingleUser") as! JSONDictionary
        let user = User(json: sample)
        XCTAssertNotNil(user)
        XCTAssertEqual(user!.id, 1)
        XCTAssertEqual(user!.name, "Leanne Graham")
        XCTAssertEqual(user!.company.name, "Romaguera-Crona")
    }

    func testParseSingleTodoFromJSON() {
        let sample = json(with: "SingleTodo") as! JSONDictionary
        let todo = Todo(json: sample)
        XCTAssertNotNil(todo)
        XCTAssertEqual(todo!.id, 1)
        XCTAssertEqual(todo!.userId, 1)
        XCTAssertEqual(todo!.title, "delectus aut autem")
        XCTAssertEqual(todo!.isCompleted, false)
    }

    func testParseUsersFromJSON() {
        let sample = json(with: "Users") as! [JSONDictionary]
        let users = sample.flatMap(User.init)
        XCTAssertEqual(users.count, 10)
    }

    func testParseSingleAlbumFromJSON() {
        let sample = json(with: "SingleAlbum") as! JSONDictionary
        let album = Album(json: sample)
        XCTAssertNotNil(album)
        XCTAssertEqual(album!.title, "quidem molestiae enim")
        XCTAssertEqual(album!.userId, 1)
        XCTAssertEqual(album!.id, 1)
    }

    func testParseAlbumsFromJSON() {
        let sample = json(with: "Albums") as! [JSONDictionary]
        let albums = sample.flatMap(Album.init)
        XCTAssertEqual(albums.count, 100)
    }

    func testFetchSingleUser() {

        let url = sampleURL(with: "SingleUser")
        let userResource = Resource<User>(url: url) { json in
            guard let dict = json as? JSONDictionary else { return nil }
            return User(json: dict)
        }

        class URLSessionMock: NetworkEngine {
            typealias Handler = NetworkEngine.Handler
            var url: URL?
            func request<A>(resource: Resource<A>, handler: @escaping NetworkEngine.Handler) {
                return 
            }
        }

        let appExpectation = expectation(description: "Get albums with userId=1")

        let webservice = Webservice(engine: URLSessionMock())
        webservice.load(userResource).onResult { result in
            if case .success(let user) = result {
                XCTAssertEqual("Leanne Graham", user.name)
            } else {
                XCTFail()
            }
            appExpectation.fulfill()
        }
        wait(for: [appExpectation], timeout: 10)
    }

    

}
