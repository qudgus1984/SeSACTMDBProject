//
//  HeaderViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/05.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class HeaderViewController: UIViewController {
    
    var castDataList: [HeaderCast] = []

    @IBOutlet weak var HeaderTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "출연/제작"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(cancelButton))

        HeaderTableView.dataSource = self
        HeaderTableView.delegate = self
        
        HeaderTableView.register(UINib(nibName: HeaderCellTableViewCell.HeaderIdentifier, bundle: nil), forCellReuseIdentifier: HeaderCellTableViewCell.HeaderIdentifier)
        
        
                
        HeaderTableView.rowHeight = 150
        
        
        
        headerDetail()
    }
    
    @objc func cancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    func headerDetail() {
        let url = "https://api.themoviedb.org/3/movie/\(TMDBViewController.movieIDChoice[UserDefaults.standard.integer(forKey: "pageNum")-1])/credits?api_key=\(APIKey.TMDBKey)&language=en-US"
        AF.request(url, method: .get ).validate(statusCode: 200...500).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                for item in json["crew"].arrayValue{
                    let data = HeaderCast(name: item["original_name"].stringValue, characterName: item["name"].stringValue, profilePath: item["profile_path"].stringValue)

                    castDataList.append(data)
                }
                HeaderTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    


}

extension HeaderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = HeaderTableView.dequeueReusableCell(withIdentifier: HeaderCellTableViewCell.HeaderIdentifier, for: indexPath) as? HeaderCellTableViewCell else { return HeaderCellTableViewCell() }
        item.nameLabel.text = castDataList[indexPath.row].name
        item.charactorLabel.text = castDataList[indexPath.row].characterName
        
        let imageURL = URL(string: EndPoint.imageURL+castDataList[indexPath.row].profilePath)
                item.profileImageView.contentMode = .scaleAspectFit
                item.profileImageView.kf.setImage(with: imageURL)

        
        return item
        
    }
    
    
}
