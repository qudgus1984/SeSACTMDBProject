//
//  HeaderTableViewCell.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/14.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var charactorLabel: UILabel!
    static let HeaderIdentifier = "HeaderTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCrewCell(data: Crew) {
        let url = URL(string: data.profile_path)
        profileImageView.kf.setImage(with: url)
        nameLabel.text = data.name
        charactorLabel.text = data.job
    }
}
