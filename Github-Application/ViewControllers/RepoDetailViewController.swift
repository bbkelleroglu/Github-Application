import SegueManager
import UIKit
class RepoDetailViewController: SegueManagerViewController {
    @IBOutlet weak var detailHeaderView: DetailHeaderComponent!
    var repositoryData: RepositoryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let repositoryData = repositoryData {
            detailHeaderView.configureRepoDetail(for: repositoryData)
            navigationItem.setTitle(title: repositoryData.fullName, subtitle: repositoryData.owner.login)
        }
    }
}
