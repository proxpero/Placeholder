
import UIKit

/// A Generic Table View Controller
final class ItemsViewController<Item, Cell: UITableViewCell>: UITableViewController {

    // MARK: Stored Properties.

    // The items on display.
    var items: [Item] {
        didSet {
            // Update UI on the main queue.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // A callback to configure `Cell` with `Item`.
    let configure: (Cell, Item) -> ()

    // A callback notifying that a row has been selected.
    var didSelect: (Item) -> () = { _ in }

    // A callback notifying that the right bar button has been tapped.
    var didTapButton: () -> () = { }

    // MARK: Initializers.

    // Initialize an `ItemsViewController` with and array of `items`, an optional bar button item, and the callback to configure cells.
    init(_ items: [Item] = [], navigationItemTitle: String? = nil, configure: @escaping (Cell, Item) -> ()) {
        self.configure = configure
        self.items = items
        super.init(style: .plain)

        // If `navigationItemTitle` exists then create a 
        // UIBarButtonItem with that title and set the selector
        // to point at `navigationBarButtonTapped` which will 
        // invoke the `didTapButton` callback.
        if let navigationItemTitle = navigationItemTitle {
            let button = UIBarButtonItem(title: navigationItemTitle, style: .plain, target: self, action: #selector(navigationBarButtonTapped))
            navigationItem.rightBarButtonItem = button
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    // `UIBarButtonItem` action. This is here to make Objc happy.
    func navigationBarButtonTapped() {
        didTapButton()
    }

    // Register the cell since this wasn't created from a nib.
    override func viewDidLoad() {
        let reuseIdentifier = "\(Cell.self)"
        tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }

    // MARK: - TableView DataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(Cell.self, at: indexPath)
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }
    
}

