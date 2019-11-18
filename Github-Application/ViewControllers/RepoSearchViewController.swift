import CancellablePromiseKit
import SegueManager
import UIKit

class RepoSearchViewController: SegueManagerViewController, RepositoryTableViewCellDelegate {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalCountLabel: UILabel!
    var searchService: RepositoryService!
    private var pages = [Page<RepositoryModel, TextModel>]()
    private var repos: [RepositoryModel] {
        pages.flatMap { $0.data }
    }
    private var numberOfItems: Int { repos.count }

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchResultsUpdater = self
        return searchController
    }()

    private var searchBar: UISearchBar { searchController.searchBar }
    private weak var currentPromise: CancellablePromise<Void>?

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

    private func loadNextPage() {
        let nextPage = pages.last!.nextPageRequest
        currentPromise?.cancel()
        currentPromise = searchService.searchRepo(body: nextPage).done {
            self.pages.append($0.page)
            let range = (self.repos.count - $0.page.data.count)..<self.repos.count
            let indexPaths = range.map { IndexPath(item: $0, section: 0) }
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.totalCountLabel.text = "\(NumberUtils.formatWithUnits($0.totalCount)) results"
        }.asCancellable()

        currentPromise?.catch { error in
            print(error)
        }
    }

    private func loadNewQuery(text: String) {
        let body = TextModel(q: text, page: 1)

        currentPromise?.cancel()
        currentPromise = searchService.searchRepo(body: body).done {
            self.pages = [$0.page]
            self.totalCountLabel.text = "\(NumberUtils.formatWithUnits($0.totalCount)) results"
            self.tableView.reloadData()
        }.asCancellable()

        currentPromise?.catch { error in
            print(error)
        }
    }

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
        if indexPath.row == numberOfItems - 1 && currentPromise?.isResolved != false {
            loadNextPage()
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
        loadNewQuery(text: text)
    }
}
