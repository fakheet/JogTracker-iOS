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

    func login() -> Single<Void> {
        Single<Void>.create { [weak self] single in
            guard let self = self else {
                return Disposables.create()
            }

            let request = AF.request(self.baseURL + "/auth/uuidLogin", method: .post, parameters: ["uuid": "hello"])

            request.responseDecodable(of: GenericResponse<LoginUUIDResponseDTO>.self, decoder: self.defaultDecoder) { response in
                switch response.result {
                case .success:
                    guard let token = response.value?.response.accessToken else { return }
                    print("token = \(token)")
                    self.token = token
                    single(.success(()))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func fetchJogs() -> Single<[JogDTO]> {
        Single<[JogDTO]>.create { [weak self] single in
            guard let self = self else {
                return Disposables.create()
            }

            let headers: HTTPHeaders = [.authorization(bearerToken: self.token)]

            let request = AF.request(self.baseURL + "/data/sync", headers: headers)
            request.responseDecodable(of: GenericResponse<SyncGetResponse>.self, decoder: self.defaultDecoder) { response in
                switch response.result {
                case .success:
                    single(.success(response.value?.response?.jogs ?? []))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func addJog() {
        // Добавить форму создания/редактирования записи о беге.
        // https://jogtracker.herokuapp.com/api/v1/data/jog
        let request = AF.request(baseURL + "/data/jog", method: .post)
    }

    func editJog() {
        let request = AF.request(baseURL + "/data/jog", method: .put)
    }
}


struct LoginUUIDResponseRoot: Decodable {
    let response: LoginUUIDResponseDTO
}

struct LoginUUIDResponseDTO: Decodable {
    let accessToken: String
}

struct SyncGetResponseRoot: Codable {
    let response: SyncGetResponse
}

struct SyncGetResponse: Codable {
    let jogs: [JogDTO]
}


struct GenericResponse<T: Decodable>: Decodable {
    let response: T?
    let error_message: String?
}