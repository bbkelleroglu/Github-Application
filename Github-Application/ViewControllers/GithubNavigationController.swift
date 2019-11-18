import UIKit
class GithubNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
        if viewControllers.first != viewController {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: R.image.back(), style: .done, target: self, action: #selector(popViewControllerAnimated))
        }
    }

    @objc
    private func popViewControllerAnimated() {
        popViewController(animated: true)
    }
}
