//
//  SecondViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/16.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelUI()

    }
    
    func labelUI() {
        tutorialLabel.numberOfLines = 0
        tutorialLabel.alpha = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 15)
        tutorialLabel.textAlignment = .left
        tutorialLabel.text = """
        TMDB는 영화 정보, 서울에 있는 영화관, 각 영화에 대한 자세한 정보 및 예고편 영상을 확인할 수 있습니다.
        
        
        상단 왼쪽에는 서울에 있는 영화관을, 상단 오른쪽에는 비슷한 영화 추천을, 영화를 클릭하면 자세한 정보를 볼 수 있습니다.
        
        
        각 셀에 있는 이미지 클립 버튼을 누르면 유튜브에서 예고편 영상을 볼 수 있습니다.
        """
        
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
        }
    }
    

}
