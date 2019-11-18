import PromiseKit
import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var detailHeaderComponent: DetailHeaderComponent!
    @IBOutlet weak var tableView: UITableView!
    var userService: UserService!
    var username: String?
    var details = [(UIImage, String, String)]()
    var pages = [Page<RepositoryModel, RepositoryPaginate>]()
    var userRepositories: [RepositoryModel] { pages.flatMap { $0.data } }
    var userRepositoriesService: RepositoryService!
    var fullname: String?
    private weak var currentPromise: Promise<Void>?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRepostories()
        loadUserDetails()
        tableView.register(R.nib.repositoryCell)
    }

    func loadUserDetails() {
        userService.userDetail(username: username!).done {
            self.detailHeaderComponent.configureUserDetail(for: $0)
            self.details = [
                (R.image.icons8Calendar50()!, "Created at", Date.getFormattedDate(date: $0.createdAt)),
                (R.image.icons8Time50()!, "Updated at", Date.getFormattedDate(date: $0.updatedAt)),
                (R.image.icons8Marker50()!, "Location", $0.location ?? "-")
            ]
            self.navigationItem.setTitle(title: self.username!, subtitle: $0.name ?? "")
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
    }

    func loadRepostories(page: RepositoryPaginate = RepositoryPaginate(page: 1)) {
        currentPromise = userRepositoriesService.userRepositoryService(username: username!, body: page).done {
            self.pages.append($0)
            let range = (self.userRepositories.count - $0.data.count)..<self.userRepositories.count
            let indexPaths = range.map { IndexPath(item: $0, section: 1) }
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        }
        currentPromise?.catch { error in
            print(error)
        }
    }
}

extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == userRepositories.count - 1 &&
            currentPromise?.isResolved != false {
            loadRepostories(page: pages.last!.nextPageRequest)
        }
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return details.count
        case 1:
            return userRepositories.count
        default:
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileDetailCell,
                                                     for: indexPath)!
            cell.configureCellData(image: details[indexPath.row].0,
                                   title: details[indexPath.row].1,
                                   value: details[indexPath.row].2)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.repositoryCell, for: indexPath)!
            cell.configure(for: userRepositories[indexPath.row])
            return cell
        default:
            fatalError("Cell is not available")
        }
    }
}
