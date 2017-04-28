
import UIKit
import CoreLocation
import MapKit

final class UserProfileViewController: UIViewController {

    // MARK: IB Outlets & Actions.

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var suiteLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var zipcodeLabel: UILabel!
    @IBOutlet var mapView: MKMapView!

    @IBAction func didTapDone(_ sender: Any) {
        dismiss()
    }

    // MARK: Stored Properties.

    /// The `User` to be displayed.
    var user: User? {
        didSet {
            refresh()
        }
    }

    /// Action to dismiss the ViewController.
    var dismiss: () -> () = {}

    // MARK: Lifecycle

    private func refresh() {
        if
            let nameLabel = nameLabel,
            let usernameLabel = usernameLabel,
            let emailLabel = emailLabel,
            let streetLabel = streetLabel,
            let suiteLabel = suiteLabel,
            let cityLabel = cityLabel,
            let zipcodeLabel = zipcodeLabel,
            let mapView = mapView
        {
            nameLabel.text = user?.name
            usernameLabel.text = user?.username
            emailLabel.text = user?.email
            streetLabel.text = user?.address.street
            suiteLabel.text = user?.address.suite
            cityLabel.text = user?.address.city
            zipcodeLabel.text = user?.address.zipcode

            if let location = user?.address.geo.location {
                // Some of these coordinates are in the middle of the ocean, so make the region large.
                let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 30_000, 30_000)
                mapView.setRegion(region, animated: true)
            }
        }
    }

    // Refresh the UI in case the models are set before the views exist.
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }

}

extension User.Address.Geo {

    /// The CLLocation of the address of the user's address
    var location: CLLocation? {
        guard let lat = Double(lat), let lng = Double(lng) else { return nil }
        return CLLocation(latitude: lat, longitude: lng)
    }

}
