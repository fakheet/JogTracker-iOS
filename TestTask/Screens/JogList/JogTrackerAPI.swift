//
// Created by mage on 21.11.2021.
//

import Alamofire
import RxSwift

class JogTrackerAPI {
    static let shared = JogTrackerAPI()
    private init() { }

    let baseURL = "https://jogtracker.herokuapp.com/api/v1"
    let token = ""

    let defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func fetchJogs() -> Single<[JogDTO]>{
        Single<[JogDTO]>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }

            let headers: HTTPHeaders = [.authorization(bearerToken: self.token)]

            let request = AF.request(self.baseURL + "/data/sync", headers: headers)

            request.responseDecodable(of: ResponseDTO.self, decoder: self.defaultDecoder) { response in
                switch response.result {
                case .success:
                    single(.success(response.value?.response.jogs ?? []))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

struct ResponseDTO: Codable {
    let response: SyncGetResponse
}

struct SyncGetResponse: Codable {
    let jogs: [JogDTO]
}

struct JogDTO: Codable {
    let id: Int
    let userId: String
    let distance: Float
    let time: Int
    let date: Int
}

