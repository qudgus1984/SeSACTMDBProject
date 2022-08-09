//
//  ImageCardView.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/09.
//

import UIKit

class ImageCardView: UIView {
    
    var colorList: [UIColor] = [UIColor.systemMint, UIColor.cyan, UIColor.systemGreen, UIColor.systemPink, UIColor.purple]


    @IBOutlet weak var cardImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        loadUI()
    }
    
    func loadView() {
        let view = UINib(nibName: "ImageCardView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        self.addSubview(view)
    }
    
    func loadUI() {
        cardImageView.backgroundColor = colorList.randomElement()
    }
    
}


