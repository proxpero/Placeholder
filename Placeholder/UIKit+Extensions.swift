
import UIKit

extension UIStoryboard {

    /// Returns the storyboard named "Main" in the main bundle.
    public static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    /// Instantiates a `UIViewController` that has a storyboard identifier
    /// that is identical to the name of the class. 
    /// **Crashes if no storyboard can be found.**
    ///
    /// - Parameter type: A type that inherits from `UIViewController`.
    /// - Returns: An instantiated view controller of type `A`.
    public func instantiate<A: UIViewController>(_ type: A.Type) -> A {
        guard let vc = self.instantiateViewController(withIdentifier: String(describing: type.self)) as? A else {
            fatalError("Could not instantiate view controller \(A.self)") }
        return vc
    }

    /// Instantiates a `UINavigationController` that has a storyboard identifier
    /// that is identical to the name of the class.
    /// **Crashes if no storyboard can be found.**
    ///
    /// - Parameter type: A type that inherits from `UINavigationController`.
    /// - Returns: An instantiated navigation controller of type `A`.
    public func instantiateNavigationController(withIdentifier identifier: String) -> UINavigationController {
        guard let nav = instantiateViewController(withIdentifier: identifier) as? UINavigationController else { fatalError("Could not create a navigation controller with identifier \(identifier).") }
        return nav
    }
    
}

extension UITableView {

    /// Dequeues a cell of type `A` at `indexPath and returns it.
    func dequeueReusableCell<A: UITableViewCell>(_ cell: A.Type, at indexPath: IndexPath) -> A {
        guard let result = self.dequeueReusableCell(withIdentifier: "\(A.self)", for: indexPath) as? A else { fatalError() }
        return result
    }
    
}

extension CGRect {

    /// Creates a square CGSize with side length `height` or `width`, whichever
    /// is smaller.
    public var maximumSquare: CGSize {
        let edge = Swift.min(width, height)
        return CGSize(width: edge, height: edge)
    }
    
}

extension UIImage {

    /// Create a UIImage of size `size` filled with `color`. Useful as 
    /// a placeholder while waiting for images on the network.
    public static func placeholder(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContext(rect.size)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// Creates a `URL` from `urlString` and loads it from the network.
    static func load(from urlString: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        loadURL(url, completion: completion)
    }

    /// Loads the image at `url` from the network.
    static func loadURL(_ url: URL, completion: @escaping (UIImage) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }

}

extension UITableViewCell {

    /// Creates a `URL` from `urlString` and loads it from the network.
    func loadImage(from urlString: String, completion: (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        loadImage(with: url, completion: completion)
    }

    /// Loads the image at `url` from the network.
    func loadImage(with url: URL, completion: (UIImage) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {                
                self.imageView?.image = image
            }
        }
        task.resume()
    }
}
