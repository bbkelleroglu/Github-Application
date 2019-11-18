import SegueManager
import UIKit

class RepoSearchViewController: SegueManagerViewController, RepositoryTableViewCellDelegate {
    func repositoryTableViewCellDidSelectAvatar(repositoryCell: RepositoryCell) {
        guard let indexPath = tableView.indexPath(for: repositoryCell) else { return }
        let username = repos[indexPath.row].owner.login
        performSegue(withIdentifier: R.segue.repoSearchViewController.userDetail) { segue in
            segue.destination.username = username
        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        touch.view?.isDescendant(of: tableView) == true
    }

    @IBOutlet weak var tableView: UITableView!
    var searchService: RepositoryService!
    private var repos = [RepositoryModel]()
    var nextPageUrl: String? = ""
    let numberOfPagination = 10
    var moreItems: Bool { nextPageUrl != nil }
    var numberOfItems: Int { repos.count }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        return searchController
    }()
    private var searchBar: UISearchBar { searchController.searchBar }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        tableView.register(R.nib.repositoryCell)
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

    private func load(text: String) {
        searchService.searchRepo(text: text).done {
            self.repos += $0
            let range = (self.repos.count - $0.count)..<self.repos.count
            let indexPaths = range.map { IndexPath(item: $0, section: 0) }
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}
extension RepoSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryCell, for: indexPath)!
        cell.configure(for: repos[indexPath.row])
        cell.delegate = self
        return cell
    }
}
extension RepoSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == numberOfItems - 1 && self.moreItems {
            load(text: searchBar.text ?? "")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDetail = repos[indexPath.row]
        self.performSegue(withIdentifier: R.segue.repoSearchViewController.repositoryDetail) { segue in
            segue.destination.repositoryData = repoDetail
        }
    }
}
extension RepoSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        load(text: text)
    }
}
