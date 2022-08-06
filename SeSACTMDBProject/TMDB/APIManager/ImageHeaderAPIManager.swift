//
//  ImageHeaderAPIManager.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/06.
//

import Foundation

import Alamofire
import SwiftyJSON

class ImageHeaderAPIManager {
        
    static let Headershared = SeSACTMDBProject.ImageHeaderAPIManager()
    
    private init() { }
    
    typealias completionHandler = (Int, [HeaderList]) -> Void
    
    func ImageHeaderAPIManager(page: Int) {
        let url = EndPoint.TMDBURL + "api_key=\(APIKey.TMDBKey)&page=\(page)"
        
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for Header in json["results"].arrayValue {
                    
                    let posterImageURL = EndPoint.imageURL + Header["poster_path"].stringValue
                    let backgroundImageURL = EndPoint.imageURL + Header["backdrop_path"].stringValue
                    let title = Header["title"].stringValue


                    
                    
                    let data = HeaderList(title: title, posterImage: posterImageURL, backgroundImage: backgroundImageURL)
                    
                    HeaderViewController.structHeaderList.append(data)
                    

                    
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

