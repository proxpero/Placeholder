
/// A User.
public struct User {

    /// A user's address.
    public struct Address {

        /// A representation of geographic coordinates.
        public struct Geo {

            /// The latitude.
            public let lat: String

            /// The longitude.
            public let lng: String

        }

        /// The street name.
        public let street: String

        /// The suite identifier.
        public let suite: String

        /// The city.
        public let city: String

        /// The zipcode.
        public let zipcode: String

        /// The geographic coordinates of the address.
        public let geo: Geo

    }

    /// A Company.
    public struct Company {

        /// The name of the company.
        public let name: String

        /// The catchphrase of the company.
        public let catchPhrase: String

        /// Some bullshit description of the company's activity.
        public let bs: String

    }

    /// The unique identifier of the user.
    public let id: Int

    /// The name of the user.
    public let name: String

    /// The username of the user.
    public let username: String

    /// The email address of the user.
    public let email: String

    /// The address of the user.
    public let address: Address

    /// The phone number of the user.
    public let phone: String
    
    /// The website of the user.
    public let website: String
    
    /// The user's company.
    public let company: Company
    
}
