//
//  CardCollectionViewCell.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCardView: ImageCardView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    func setupUI() {
        imageCardView.backgroundColor = .clear
        imageCardView.cardImageView.backgroundColor = .systemPink
        imageCardView.cardImageView.layer.cornerRadius = 10
        
    }
}
