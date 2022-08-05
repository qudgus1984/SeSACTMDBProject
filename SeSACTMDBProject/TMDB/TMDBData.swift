//
//  TMDBData.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/04.
//

import Foundation


struct TMDBList {
    
    let releaseDate: String
    let genre: Int
    let posterImage: String
    let rate: Double
    let title: String
    let overview: String
    
}



enum TMDBGenre: Int, CaseIterable {
    case id28 = 28
    case id12 = 12
    case id16 = 16
    case id35 = 35
    case id80 = 80
    case id99 = 99
    case id18 = 18
    case id10751 = 10751
    case id14 = 14
    case id36 = 36
    case id27 = 27
    case id10402 = 0402
    case id9648 = 9648
    case id10749 = 10749
    case id878 = 78
    case id10770 = 10770
    case id53 = 53
    case id10752 = 10752
    case id37 = 37
    
    var comparing: String {
        switch self {
        case .id28: return "액션"
        case .id12: return "모험"
        case .id16: return "애니메이션"
        case .id35: return "코미디"
        case .id80: return "범죄"
        case .id99: return "다큐멘터리"
        case .id18: return "드라마"
        case .id10751: return "가족"
        case .id14: return "판타지"
        case .id36: return "역사"
        case .id27: return "공포"
        case .id10402: return "음악"
        case .id9648: return "미스터리"
        case .id10749: return "로맨스"
        case .id878: return "SF"
        case .id10770: return "TV 영화"
        case .id53: return "스릴러"
        case .id10752: return "전쟁"
        case .id37: return "서부"
        }
    }
    
}
