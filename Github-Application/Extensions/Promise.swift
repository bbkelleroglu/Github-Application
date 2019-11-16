import RestingKit
import PromiseKit

extension Promise where T: HTTPResponseType {
    func extractingBody() -> Promise<T.BodyType> {
        return map { $0.body }
    }
}

