
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

public enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

extension HttpMethod {

    func map<A>(transform: (Body) -> A) -> HttpMethod<A> {
        switch self {
        case .get: return .get
        case .post(let body):
            return .post(transform(body))
        }
    }
}

func baseURL(with scheme: String, host: String, path: String? = nil) -> String {
    var result = "\(scheme)://\(host)"
    if let path = path {
        result += "/\(path)"
    }
    return result
}



let url = URL(string: baseURL(with: "https", host: "jsonplaceholder.typicode.com"))!

let userURL = baseURL(with: "https", host: "jsonplaceholder.typicode.com").appending("/users")
let albumURL = url.appendingPathExtension("albums?userID=1")
print(albumURL)

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

extension User {

    static var allURLString: String {
        return baseURL(with: "https", host: "jsonplaceholder.typicode.com").appending("/users")
    }

    static var allURL: URL {
        return URL(string: allURLString)!
    }

    static let all = Resource<[User]>(
        url: User.allURL,
        parseJSON: { json  in
        guard let dicts = json as? [JSONDictionary] else { return nil }
        return dicts.flatMap(User.init)
    })

}

func pushNotification(token: String) -> Resource<Bool> {
    let url = URL(string: "")!
    let dictionary = ["token": token]
    return Resource(url: url, method: .post(dictionary), parseJSON: { _ in
        return true
    })
}

extension URLRequest {

    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        self.httpMethod = resource.method.method
        if case .post(let data) = resource.method {
            httpBody = data
        }
    }

}

public final class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: URLRequest(resource: resource)) { (data, _, _) in
            let result = data.flatMap(resource.parse)
            completion(result)
            }.resume()
    }
}

let request = URLRequest(resource: User.all)

let ws = Webservice()
ws.load(resource: User.all) { data in
    print(data ?? "none")
}
