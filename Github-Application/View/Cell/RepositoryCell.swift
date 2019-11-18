import AlamofireImage
import UIKit

protocol RepositoryTableViewCellDelegate: UIGestureRecognizerDelegate {
    func repositoryTableViewCellDidSelectAvatar(repositoryCell: RepositoryCell)
}

class RepositoryCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var language: UILabel!

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
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.borderWidth = 1

        repoName.text = repository.fullName
        repoDescription.text = repository.description
        language.text = repository.language
        starCount.text = String(NumberUtils.formatWithUnits(repository.stargazersCount))

        if let avatarImageUrl = repository.owner.avatarUrl {
            avatarImage.image = nil
            avatarImage.af_setImage(withURL: avatarImageUrl)
        } else {
            avatarImage.af_cancelImageRequest()
            avatarImage.image = .checkmark
        }
        avatarImage.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func avatarClicked(_ sender: UITapGestureRecognizer) {
        self.delegate?.repositoryTableViewCellDidSelectAvatar(repositoryCell: self)
    }
}
