import UIKit
@IBDesignable
class DetailHeaderComponentView: UIView {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstHeaderCardView: HeaderCardComponent!
    @IBOutlet weak var secondHeaderCardView: HeaderCardComponent!
    @IBOutlet weak var thirdHeaderCardView: HeaderCardComponent!
}

@IBDesignable
class DetailHeaderComponent: Component {
    private weak var view: DetailHeaderComponentView!
    var text: String? {
        get { return view.descriptionLabel.text }
        set { view.descriptionLabel.text = newValue }
    }

    var image: UIImage? {
        get { return view.avatarImage.image }
        set { view.avatarImage.image = newValue }
    }

    func configureUserDetail(for user: UserModelResponse) {
        if let image = user.avatarUrl {
            view.avatarImage.af_setImage(withURL: image)
        } else {
            view.avatarImage.af_cancelImageRequest()
            view.avatarImage.image = .checkmark
        }
        view.descriptionLabel.text = user.bio
        view.firstHeaderCardView.countText = String(user.followers)
        view.firstHeaderCardView.nameText = "Followers"
        view.secondHeaderCardView.countText = String(user.following)
        view.secondHeaderCardView.nameText = "Following"
        view.thirdHeaderCardView.countText = String(user.publicRepos)
        view.thirdHeaderCardView.nameText = "Repository"
    }
    func configureRepoDetail(for repo: RepositoryModel)  {
        if let image = repo.owner.avatarUrl {
            view.avatarImage.af_setImage(withURL: image)
        } else {
            view.avatarImage.af_cancelImageRequest()
            view.avatarImage.image = .checkmark
        }
        view.descriptionLabel.text = repo.description
        view.firstHeaderCardView.countText = String(repo.stargazersCount)
        view.firstHeaderCardView.nameText = "Stars"
        view.secondHeaderCardView.countText = String(repo.watchersCount)
        view.secondHeaderCardView.nameText = "Watchers"
        view.thirdHeaderCardView.countText = String(repo.forksCount)
        view.thirdHeaderCardView.nameText = "Forks"
    }

    override func didLoad(subview: UIView) {
        view = (subview as! DetailHeaderComponentView)
    }
}
