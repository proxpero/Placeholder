
import Foundation

public struct URLProvider {

    public let scheme: String
    public let host: String
    public let baseURL: URL

    public init(scheme: String = "https", host: String) {
        self.scheme = scheme
        self.host = host
        self.baseURL = {
            guard let url = URL(string: scheme + "://" + host) else {
                fatalError("Could not create base url from scheme: \(scheme) and host: \(host)")
            }
            return url
        }()
    }

}
