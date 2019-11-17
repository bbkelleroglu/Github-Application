import UIKit
class DetailComponentView: UIView {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
}
class DetailComponent: Component {
    private weak var view: DetailComponentView!
    var text: String? {
        get { return view.descriptionLabel.text }
        set { view.descriptionLabel.text = newValue }
    }

    var image: UIImage? {
        get { return view.avatarImage.image }
        set { view.avatarImage.image = newValue }
    }

    override func didLoad(subview: UIView) {
        view = (subview as! DetailComponentView)
    }
}
