import Foundation
import RestingKit

class NetworkService {
    private let config: Config
    private let httpClient: RestingClient
    private let converter: RestingRequestConverter

    init(config: Config) {
        self.config = config
        converter = RestingRequestConverter(jsonEncoder: config.jsonEncoder,
                                            queryParameterEncoder: config.queryParameterEncoder)
        httpClient = RestingClient(baseUrl: config.baseUrl,
                                   decoder: config.jsonDecoder,
                                   requestConverter: converter,
                                   interceptors: [RequestResponseLoggingInterceptor()])
    }

    func httpCall() -> RestingClient {
        return httpClient
    }
}
