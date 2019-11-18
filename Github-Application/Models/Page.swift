import Foundation

protocol PageRequest: Encodable {
    var page: Int { get }

    var next: Self { get }
}

struct Page<DataType, RequestType: PageRequest> {
    let data: [DataType]
    let request: RequestType

    var nextPageRequest: RequestType { request.next }
}
