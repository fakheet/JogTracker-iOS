//
// Created by mage on 21.11.2021.
//

import Alamofire
import RxSwift

class JogTrackerAPI {
    static let shared = JogTrackerAPI()
    private init() { }

    private let baseURL = "https://jogtracker.herokuapp.com/api/v1"

    typealias Token = String
    private var token = ""

    private let sendDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()

    let defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func login() -> Single<LoginUUIDResponseDTO> {
        makeRequest(path: "/auth/uuidLogin", method: .post, parameters: ["uuid": "hello"]) { type in
            guard let token = type?.accessToken else { return }
            print("token = \(token)")
            self.token = token
        }
    }

    func fetchJogs() -> Single<SyncGetResponse> {
        makeRequest(path: "/data/sync", headers: [.authorization(bearerToken: token)])
    }

    func addNewJog(_ jog: JogDTO) -> Single<JogTimestampedDTO> {
        makeRequest(
            path: "/data/jog",
            method: .post,
            headers: [.authorization(bearerToken: token)],
            parameters: [
                "date": sendDateFormatter.string(from: Date(timeIntervalSince1970: Double(jog.date))),
                "time": jog.time,
                "distance": jog.distance
            ]
        )
    }

    func editJog(_ jog: JogDTO) -> Single<JogTimestampedDTO> {
        makeRequest(
            path: "/data/jog",
            method: .put,
            headers: [.authorization(bearerToken: token)],
            parameters: [
                "jog_id": jog.id,
                "user_id": jog.userId,
                "date": sendDateFormatter.string(from: Date(timeIntervalSince1970: Double(jog.date))),
                "time": jog.time,
                "distance": jog.distance
            ]
        )
    }

    func makeRequest<ReturnType: Decodable>(
        path: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders = [],
        parameters: [String: Any] = [:],
        onComplete: ((ReturnType?) -> ())? = nil
    ) -> Single<ReturnType> {
        Single<ReturnType>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }

            let request = AF.request(self.baseURL + path, method: method, parameters: parameters, headers: headers)

            request.responseDecodable(of: GenericResponse<ReturnType>.self, decoder: self.defaultDecoder) { response in
                switch response.result {
                case .success:
                    if let response = response.value?.response {
                        onComplete?(response)
                        single(.success(response))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

struct GenericResponse<T: Decodable>: Decodable {
    let response: T?
    let error_message: String?
}