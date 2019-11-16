import UIKit
import SegueManager

class RepoSearchViewController: UIViewController {
    var searchService: SearchService!
    private var repos = [RepositoryModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
