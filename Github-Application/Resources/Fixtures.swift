import Foundation
import Yams

private func loadFixture<T: Decodable>(url: URL, decoder: YAMLDecoder) -> T {
    //swiftlint:disable:next force_try
    let content = try! String(contentsOf: url)
    //swiftlint:disable:next force_try
    return try! decoder.decode(T.self, from: content, userInfo: [:])
}

class Fixtures {
    let repository: [RepositoryModel]
    let userDetail: UserModelResponse

    init(yamlDecoder: YAMLDecoder) {
        repository = loadFixture(url: R.file.repositoryYml()!, decoder: yamlDecoder)
        userDetail = loadFixture(url: R.file.userDetailYml()!, decoder: yamlDecoder)
    }
}
