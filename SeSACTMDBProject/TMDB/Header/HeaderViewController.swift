//
//  HeaderViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/05.
//

import UIKit

class HeaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "출연/제작"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(cancelButton))

    }
    
    @objc func cancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    


}
