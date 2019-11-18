import UIKit
import SegueManager
class RepoDetailViewController: SegueManagerViewController {

    @IBOutlet weak var detailHeaderView: DetailHeaderComponent!
    var repositoryData: RepositoryModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let repositoryData = repositoryData {
            detailHeaderView.configureRepoDetail(for: repositoryData)
        }
        // Do any additional setup after loading the view.
    }
}
