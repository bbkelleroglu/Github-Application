import AlamofireImage
import UIKit
class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var repoAvatarImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var languageName: UILabel!

    func configure(for repository: RepositoryModel) {
        repoAvatarImage.layer.cornerRadius = repoAvatarImage.frame.width / 2
        repoAvatarImage.layer.masksToBounds = true
        repoAvatarImage.layer.borderColor = UIColor.white.cgColor
        repoAvatarImage.layer.borderWidth = 1

        repoName.text = repository.fullName
        repoDescription.text = repository.description
        languageName.text = repository.language
        starCount.text = String(repository.stargazersCount)

        if let avatarImage = repository.avatarUrl {
            repoAvatarImage.image = nil
            repoAvatarImage.af_setImage(withURL: avatarImage)
        } else {
            repoAvatarImage.af_cancelImageRequest()
            repoAvatarImage.image = .checkmark
        }
    }
}
