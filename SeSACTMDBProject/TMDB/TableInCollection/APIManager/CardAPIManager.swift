//
//  CardAPIManager.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/10.
//

import UIKit

import Alamofire
import SwiftyJSON


/*
 TMDB API
 https://developers.themoviedb.org/3/tv-seasons/get-tv-season-details
 */
class CardAPIManager {
    
    static let shared = CardAPIManager()
    
    private init() { }
    
    let movieList = [
        ("Thor: Love and Thunder", 616037),
        ("The Gray Man", 725201),
        ("The Black Phone", 756999),
        ("Minions: The Rise of Gru", 438148),
        ("The Sandman", 90802),
        ("Prey", 766507),
        ("Luck", 585511),
        ("Thirteen Lives", 698948)
    ]
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    func callRequest(query: Int, completionHandler: @escaping ([String]) -> ()) {
        print(#function)
        let url = "https://api.themoviedb.org/3/movie/\(query)/similar?api_key=\(APIKey.TMDBKey)&language=en-US&page=1"
        
        //Alamofire -> URLSession Framework -> 비동기로 Request
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                //json still_path > [String]
//                var stillArray: [String] = []
//                for list in json["episodes"].arrayValue {
//                    let value = list["still_path"].stringValue
//                    stillArray.append(value)
//                }
                
                // 고차함수를 이용하여 위 코드 변환
                let value = json["results"].arrayValue.map { $0["poster_path"].stringValue }
                
                dump(value) // print vs dump
                
                completionHandler(value)
                                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        //나~~~~중에 배울 것: async/await(iOS13 이상)
        CardAPIManager.shared.callRequest(query: movieList[0].1) { value in
            posterList.append(value)

            CardAPIManager.shared.callRequest(query: self.movieList[1].1) { value in
                posterList.append(value)

                CardAPIManager.shared.callRequest(query: self.movieList[2].1) { value in
                    posterList.append(value)
                   
                    CardAPIManager.shared.callRequest(query: self.movieList[3].1) { value in
                        posterList.append(value)
                     
                        CardAPIManager.shared.callRequest(query: self.movieList[4].1) { value in
                            posterList.append(value)
                           
                            CardAPIManager.shared.callRequest(query: self.movieList[5].1) { value in
                                posterList.append(value)
                                
                                CardAPIManager.shared.callRequest(query: self.movieList[6].1) { value in
                                    posterList.append(value)
                                    
                                    CardAPIManager.shared.callRequest(query: self.movieList[7].1) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
