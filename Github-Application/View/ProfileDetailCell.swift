import UIKit

class ProfileDetailCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func configureCellData(image: UIImage, title: String, value: String) {
        iconImage.image = image
        titleLabel.text = title
        valueLabel.text = value
    }

}
