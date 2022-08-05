//
//  TMDBCollectionViewCell.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/04.
//

import UIKit


class TMDBCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var titleNameLabel: UILabel!
    
    @IBOutlet weak var explainLabel: UILabel!
    
    static let identifier = "TMDBCollectionViewCell"
    @IBOutlet weak var posterImageView: UIImageView!
   
    func setData(indexPath: IndexPath, list: [TMDBList]) {
        self.rateLabel.text = "\(list[indexPath.row].rate)"
        self.titleNameLabel.text = list[indexPath.row].title
        self.dateLabel.text = list[indexPath.row].releaseDate
        self.titleLabel.text = TMDBGenre(rawValue: list[indexPath.row].genre)?.comparing
        self.explainLabel.text = list[indexPath.row].overview
        
        let url = URL(string: list[indexPath.row].posterImage)
        self.posterImageView.kf.setImage(with: url)
        
    }
}
