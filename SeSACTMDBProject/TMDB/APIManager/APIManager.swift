import Foundation

import Alamofire
import SwiftyJSON

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    //MARK: - Main 네트워크 통신
    func fetchMovie(page: Int, completionHandler: @escaping (JSON) -> ()) {
        
        let url = "\(EndPoint.TMDBURL)api_key=\(APIKey.TMDBKey)&page=\(page)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchGenre(completionHandler: @escaping (JSON) -> ()) {
        
        let url = "\(EndPoint.genre)?api_key=\(APIKey.TMDBKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchVideo(id: Int, completionHandler: @escaping (JSON) -> ()) {
        
        let url = "\(EndPoint.crew)/\(id)/videos?api_key=\(APIKey.TMDBKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Detail 네트워크
    func fetchCastCrew(movieId: Int, completionHandler: @escaping (JSON) -> ()) {
        
        let url = "\(EndPoint.crew)/\(movieId)/credits?api_key=\(APIKey.TMDBKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
            completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
