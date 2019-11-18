import UIKit

class UserDetailViewController: UIViewController, RepositoryTableViewCellDelegate {
    func repositoryTableViewCellDidSelectAvatar(repositoryCell: RepositoryCell) {
        
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        touch.view?.isDescendant(of: tableView) == true
    }

    @IBOutlet weak var detailHeaderComponent: DetailHeaderComponent!
    @IBOutlet weak var tableView: UITableView!
    var userService: UserService!
    var username: String?
    var details = [(UIImage, String, String)]()
    var userRepositories = [RepositoryModel]()
    var userRepositoriesService: RepositoryService!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = username else { return }
        userRepositoriesService.userRepositoryService(username: username).done {
            self.userRepositories += $0
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
        userService.userDetail(username: username).done {
            self.detailHeaderComponent.configureUserDetail(for: $0)
            self.details = [
                (#imageLiteral(resourceName: "icons8-calendar-50"), "Created at", "\($0.createdAt)"),
                (#imageLiteral(resourceName: "icons8-time-50"), "Updated at", "\($0.updatedAt)"),
                (#imageLiteral(resourceName: "icons8-marker-50"), "Location", "\($0.location ?? "-")")
            ]
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
        tableView.register(R.nib.repositoryCell)
    }
}
extension UserDetailViewController: UITableViewDelegate {
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
            cell.delegate = self
            return cell
        default:
            fatalError("Cell is not available")
        }
    }
}
