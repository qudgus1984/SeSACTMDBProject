//
//  MainTMDBCollectionViewCell.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/11.
//

import UIKit

class MainTMDBCollectionViewCell: UICollectionViewCell, ReusableViewProtocol {
    static var reuseIdentifier = "MainTMDBCollectionViewCell"
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var inView: UIView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var vateTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layout()
    }
    
    func configCell(data: Movie) {
        //        let date = DateFormatter()
        //        date.dateFormat = "yyyy.mm.dd"
        //        guard let newDate = date.date(from: data.release)
        dataLabel.text = data.release
        
        voteLabel.text = " "+String(format: "%.1f", Double(data.vote))+" "
        vateTitleLabel.text = " 평점 "
        titleLabel.text = data.title
        overViewLabel.text = data.overview
        
        let url = URL(string: data.image)
        posterImageView.kf.setImage(with: url)
        
    }
    
    func layout() {
        inView.layer.masksToBounds = true
        inView.layer.cornerRadius = 7
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        dataLabel.font = .systemFont(ofSize: 12)
        genreLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        overViewLabel.font = .systemFont(ofSize: 17)
        overViewLabel.textColor = .darkGray
        
        lineView.layer.borderWidth = 1
        
        voteLabel.font = .systemFont(ofSize: 12)
        voteLabel.backgroundColor = .white
        
        vateTitleLabel.font = .systemFont(ofSize: 12)
        vateTitleLabel.backgroundColor = .purple
        
        
        linkButton.tintColor = .white
        
        posterImageView.contentMode = .scaleAspectFill
        
    }
    
}


