import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var detailHeaderComponent: DetailHeaderComponent!
    var userService: UserService!
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = username else { return }
        userService.userDetail(username: username).done {
            self.detailHeaderComponent.configureUserDetail(for: $0)
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
