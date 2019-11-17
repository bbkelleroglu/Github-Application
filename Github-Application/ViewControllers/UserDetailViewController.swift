import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var detailHeaderComponent: DetailHeaderComponent!
    var userService: UserService!
    var username: String?
    var details: [(UIImage, String, String)]?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = username else { return }
        userService.userDetail(username: username).done {
            self.detailHeaderComponent.configureUserDetail(for: $0)
            self.details = [
                (#imageLiteral(resourceName: "icons8-calendar-50"),"Created at", "\($0.createdAt)"),
                (#imageLiteral(resourceName: "icons8-time-50"),"Updated at", "\($0.updatedAt)"),
                (#imageLiteral(resourceName: "icons8-marker-50"),"Location", "\($0.location ?? "-")")
            ]
        }.catch { error in
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
extension UserDetailViewController: UITableViewDelegate {

}
extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 0
        default:
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileDetailCell, for: indexPath)!
        cell.configureCellData(image: details![indexPath.row].0, title: details![indexPath.row].1, value: details![indexPath.row].2)
        return cell
    }


}
