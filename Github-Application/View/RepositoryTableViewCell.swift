import AlamofireImage
import UIKit
protocol RepositoryTableViewCellDelegate: UIGestureRecognizerDelegate {
    func repositoryTableViewCellDidSelectAvatar(repositoryCell: RepositoryTableViewCell)
}
class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var repoAvatarImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var languageName: UILabel!
    weak var delegate: RepositoryTableViewCellDelegate? {
        didSet {
            gestureRecognizer.delegate = delegate
        }
    }
    let gestureRecognizer = UITapGestureRecognizer()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        gestureRecognizer.addTarget(self, action: #selector(avatarClicked(_:)))
    }

    func configure(for repository: RepositoryModel) {
        repoAvatarImage.layer.cornerRadius = repoAvatarImage.frame.width / 2
        repoAvatarImage.layer.masksToBounds = true
        repoAvatarImage.layer.borderColor = UIColor.white.cgColor
        repoAvatarImage.layer.borderWidth = 1

        repoName.text = repository.fullName
        repoDescription.text = repository.description
        languageName.text = repository.language
        starCount.text = String(repository.stargazersCount)

        if let avatarImage = repository.owner.avatarUrl {
            repoAvatarImage.image = nil
            repoAvatarImage.af_setImage(withURL: avatarImage)
        } else {
            repoAvatarImage.af_cancelImageRequest()
            repoAvatarImage.image = .checkmark
        }
        repoAvatarImage.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func avatarClicked(_ sender: UITapGestureRecognizer) {
        self.delegate?.repositoryTableViewCellDidSelectAvatar(repositoryCell: self)
    }
}
