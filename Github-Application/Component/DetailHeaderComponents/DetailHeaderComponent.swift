import UIKit
@IBDesignable
class DetailHeaderComponentView: UIView {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
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

    override func didLoad(subview: UIView) {
        view = (subview as! DetailHeaderComponentView)
    }
}
