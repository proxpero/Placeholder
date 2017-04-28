
import UIKit

struct CellDescriptor {
    let cellClass: UITableViewCell.Type
    let reuseIdentifier: String
    let configure: (UITableViewCell) -> ()

    init<Cell: UITableViewCell>(reuseIdentifier: String, configure: @escaping (Cell) -> ()) {
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        self.configure = { cell in
            // Erase the type. The type signature of the parameter guarantees that `cell` is a `Cell`
            configure(cell as! Cell)
        }
    }
}

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

    let cellDescriptor: (Item) -> CellDescriptor

    private var reuseIdentifiers: Set<String> = []

    /*
    // A callback to configure `Cell` with `Item`.
    let configure: (Cell, Item) -> ()
    */

    // A callback notifying that a row has been selected.
    var didSelect: (Item) -> () = { _ in }

    // A callback notifying that the right bar button has been tapped.
    var didTapButton: () -> () = { }

    // MARK: Initializers.

    init(items: [Item] = [], navigationItemTitle: String? = nil, cellDescriptor: @escaping (Item) -> CellDescriptor) {
        self.items = items
        self.cellDescriptor = cellDescriptor
        super.init(style: .plain)
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
//        let cell = tableView.dequeueReusableCell(Cell.self, at: indexPath)
        let item = items[indexPath.row]
        let descriptor = cellDescriptor(item)
        if !reuseIdentifiers.contains(descriptor.reuseIdentifier) {
            tableView.register(descriptor.cellClass, forCellReuseIdentifier: descriptor.reuseIdentifier)
            reuseIdentifiers.insert(descriptor.reuseIdentifier)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
        descriptor.configure(cell)
        return cell
    }
    
}

