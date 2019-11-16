import SegueManager
import UIKit

class RepoSearchViewController: SegueManagerViewController {
    @IBOutlet weak var tableView: UITableView!

    var searchService: SearchService!
    private var repos = [RepositoryModel]()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        return searchController
    }()
    private var searchBar: UISearchBar { searchController.searchBar }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }

    private func setupSearchBar() {
        definesPresentationContext = true
        searchBar.barStyle = .default
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Repository Search"
        searchBar.tintColor = .white
        self.navigationItem.searchController = searchController
    }
}
extension RepoSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryCell, for: indexPath)!
        cell.configure(for: repos[indexPath.row])
        return cell
    }
}
extension RepoSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
extension RepoSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchService.searchRepo(text: text).done {
            self.repos = $0
            self.tableView.reloadData()
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}
