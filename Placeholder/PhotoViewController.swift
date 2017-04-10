
import UIKit

/// Displays the full-size photo and its title
final class PhotoViewController: UIViewController {

    // MARK: IB Outlets & Actions.

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!

    // MARK: Stored Properties.

    /// The photo to be displayed.
    var photoImage: UIImage? {
        didSet {
            refresh()
        }
    }

    /// The title of the photo.
    var photoTitle: String? {
        didSet {
            refresh()
        }
    }

    // MARK: Lifecycle.

    private func refresh() {
        if let imageView = imageView {
            imageView.image = photoImage
        }
        if let label = label {
            let result = photoTitle ?? "Title"
            label.text = result
            label.sizeToFit()
        }
    }

    // Refresh the UI in case the models are set before the views exist.
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
}

