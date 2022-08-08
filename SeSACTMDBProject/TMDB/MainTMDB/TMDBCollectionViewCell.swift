//
//  TMDBCollectionViewCell.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/04.
//

import UIKit


class TMDBCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    static let identifier = "TMDBCollectionViewCell"
    @IBOutlet weak var posterImageView: UIImageView!
   
    var genre: [TMDBGenre] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configCell(data: Movie) {
        let date = DateFormatter()
        date.dateFormat = "yyyy.mm.dd"
        let newDate = date.date(from: data.release)
        dateLabel.text = date.string(from: newDate!)
        
        rateLabel.text = String(Int(data.vote))
        titleLabel.text = data.title
        explainLabel.text = data.overview
        
        let url = URL(string: data.image)
        posterImageView.kf.setImage(with: url)
        

        
    }

}
