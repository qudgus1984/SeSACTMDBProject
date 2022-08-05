//
//  ImageTMDBAPIManager.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON


class ImageTMDBAPIManager {
        
    static let shared = ImageTMDBAPIManager()
    
    private init() { }
    
    typealias completionHandler = (Int, [TMDBList]) -> Void
    
    func fetchTMDB(page: Int, completionHandler: @escaping completionHandler ) {
        let url = EndPoint.TMDBURL + "api_key=\(APIKey.TMDBKey)&page=\(page)"
        
        AF.request(url, method: .get).validate().responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for TMDB in json["results"].arrayValue {
                    
                    let imageUrl = EndPoint.imageURL + TMDB["poster_path"].stringValue
                    let releaseDate = TMDB["release_date"].stringValue
                    let rate = TMDB["vote_average"].doubleValue
                    let title = TMDB["name"].stringValue
                    let overview = TMDB["overview"].stringValue
                    let genre = TMDB["genre_ids"][0].intValue
                    
                    
                    let data = TMDBList(releaseDate: releaseDate, genre: genre, posterImage: imageUrl, rate: rate, title: title, overview: overview)
                    
                    TMDBViewController.listStruct.append(data)
                    
                    let totalCount = json["total_pages"].intValue

                    completionHandler(totalCount, TMDBViewController.listStruct)
                    
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
