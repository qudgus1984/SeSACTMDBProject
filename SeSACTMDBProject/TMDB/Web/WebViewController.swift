//
//  WebViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/07.
//

import UIKit
import WebKit

import Alamofire
import SwiftyJSON

class WebViewController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    var key: String?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(dismissView))
        guard let key = key else { return }
        openWebPage(url: key)
    }
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openWebPage(url: String) {
        let stringUrl = EndPoint.youtube + url
        guard let url = URL(string: stringUrl) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
