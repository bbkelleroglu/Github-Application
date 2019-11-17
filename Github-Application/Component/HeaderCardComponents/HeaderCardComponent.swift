import UIKit
@IBDesignable
class HeaderCardComponentView: UIView {
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}
@IBDesignable
class HeaderCardComponent: Component {
    private weak var view: HeaderCardComponentView!

    var countText: String? {
        get { return view.countLabel.text }
        set { view.countLabel.text = newValue }
    }

    var nameText: String? {
        get { return view.nameLabel.text }
        set { view.nameLabel.text = newValue }
    }

    override func didLoad(subview: UIView) {
        view = (subview as! HeaderCardComponentView)
    }
}
