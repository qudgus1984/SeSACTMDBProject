//
//  HeaderCellTableViewCell.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/06.
//

import UIKit

class HeaderCellTableViewCell: UITableViewCell {
    
    static let HeaderIdentifier = "HeaderCellTableViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var charactorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configCrewCell(data: Crew) {
        let url = URL(string: data.profile_path)
        profileImageView.kf.setImage(with: url)
        nameLabel.text = data.name
        charactorLabel.text = data.job
    }
}







