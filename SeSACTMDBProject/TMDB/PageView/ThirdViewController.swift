//
//  ThirdViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/16.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelUI()
    }
    
    func labelUI() {
        tutorialLabel.numberOfLines = 0
        tutorialLabel.alpha = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 48)
        tutorialLabel.textAlignment = .center
        tutorialLabel.text = """
        TMDB의 세계에 빠져보세요.
        """
        
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
        }
    }
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "MainTMDB", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainTMDBViewController") as! MainTMDBViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        UserDefaults.standard.set(true, forKey: "First")
    }
    
}
