//
//  SearchingYouTubeManager.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/08.
//

import Foundation

import Alamofire
import SwiftyJSON

class SearchingYouTubeManager {
    
    private init() { }
    
    static let shared = SearchingYouTubeManager()
    
    typealias completionHandler = (String) -> Void
    
    func fetchingMovieLinkData(movieID: Int, completionHandler: @escaping completionHandler) {

        let url = EndPoint.TMDBURL + "\(TMDBViewController.movieIDChoice[UserDefaults.standard.integer(forKey: "pageNum")-1])/\(movieID)/videos?api_key=\(APIKey.TMDBKey)&language=en-US"
        
        AF.request(url, method: .get).validate(statusCode: 200...400).responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")

                let link = "https://www.youtube.com/watch?v=\(json["results"][0]["key"].stringValue)"

                completionHandler(link)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

