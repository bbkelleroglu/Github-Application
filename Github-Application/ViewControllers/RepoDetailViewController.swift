import SegueManager
import UIKit
class RepoDetailViewController: SegueManagerViewController, ImageViewGestureDelegate {
    func avatarImageClickGesture() {
        performSegue(withIdentifier: R.segue.repoDetailViewController.userDetailFromRepoDetail) { segue in
            segue.destination.username = self.repositoryData?.owner.login
        }
    }

    @IBOutlet weak var detailHeaderView: DetailHeaderComponent!
    var repositoryData: RepositoryModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        detailHeaderView.delegate = self
        if let repositoryData = repositoryData {
            detailHeaderView.configureRepoDetail(for: repositoryData)
            navigationItem.setTitle(title: repositoryData.fullName, subtitle: repositoryData.owner.login)
        }
    }
}
