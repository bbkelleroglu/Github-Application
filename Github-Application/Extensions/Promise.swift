import PromiseKit
import RestingKit

extension Promise where T: HTTPResponseType {
    func extractingBody() -> Promise<T.BodyType> {
        return map { $0.body }
    }
}

extension Promise where T: Collection {
    func toPage<RequestType: PageRequest>(with request: RequestType) -> Promise<Page<T.Element, RequestType>> {
        map {
            Page(data: [T.Element]($0), request: request)
        }
    }
}
