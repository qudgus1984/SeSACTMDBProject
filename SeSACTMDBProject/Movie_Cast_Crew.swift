//
//  Movie_Cast_Crew.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/11.
//

import Foundation

import Foundation

struct Movie {
    let title: String
    let release: String
    let overview: String
    let image: String
    let vote: Double
    let poster: String
    let movieid: Int
    let genreid: Int
}

struct Cast {
    
    let name: String
    let character: String
    let profile_path: String
    
}

struct Crew {
    
    let name: String
    let job: String
    let profile_path: String
}
