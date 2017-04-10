
/// A (partial) representation the endpoints available
/// from the JSONPlaceholder API.
public enum Endpoint {

    /// The `users` endpoint.
    case users

    /// The `albums` endpoint.
    case albums(userId: Int)

    /// The `photos` endpoint.
    case photos(albumId: Int)

    /// The string value of the endpoint as used in a network request.
    public var stringValue: String {
        switch self {
        case .users:
            return "users"
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        }
    }

    /// The query parameters passed with the endpoint.
    public var parameters: [String: AnyObject]? {
        switch self {
        case .users:
            return nil
        case .albums(userId: let id):
            return ["userId": id as AnyObject]
        case .photos(albumId: let id):
            return ["albumId": id as AnyObject]
        }
    }

}
