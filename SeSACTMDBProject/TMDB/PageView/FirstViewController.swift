//
//  FirstViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelUI()
        viewUI()
    }
    
    func labelUI() {
        tutorialLabel.numberOfLines = 0
        tutorialLabel.alpha = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 15)
        tutorialLabel.textAlignment = .left
        tutorialLabel.text = """
        [SeSAC] TMDB Application에 오신 것을 환영합니다.
        
        
        TMDB App은 최신 영화를 소개해주는 앱입니다.
        """
        
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
        }
    }
    
    func viewUI() {
        lineView.backgroundColor = .black
        lineView.alpha = 0
        UIView.animate(withDuration: 2) {
            self.lineView.alpha = 1
        }
    }
    



}
