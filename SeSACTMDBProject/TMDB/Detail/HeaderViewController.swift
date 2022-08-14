//
//  HeaderViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/05.


import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class HeaderViewController: UIViewController {
    
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overViewTextView: UITextView!
    
    var movieData: Movie?
    var crewInfo: [Crew] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "출연/제작"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(cancelButton))
        
        HeaderTableView.dataSource = self
        HeaderTableView.delegate = self
        
        HeaderTableView.register(UINib(nibName: HeaderTableViewCell.HeaderIdentifier, bundle: nil), forCellReuseIdentifier: HeaderTableViewCell.HeaderIdentifier)
        
        
        viewLayout()
        loadData()
        
        guard let movieData = movieData else { return }
        fetchCastCrewByAPIManager(moiveID: movieData.movieid)
    }
    
    @objc func cancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchCastCrewByAPIManager(moiveID: Int) {
        APIManager.shared.fetchCastCrew(movieId: moiveID) { json in
            
            self.overViewTextView.text = self.movieData?.overview
            
            
            for crew in json["crew"].arrayValue {
                let name = crew["name"].stringValue
                let job = crew["job"].stringValue
                let profile = EndPoint.imageURL + crew["profile_path"].stringValue
                
                let data = Crew(name: name, job: job, profile_path: profile)
                self.crewInfo.append(data)
                print("====== crew name: \(name) ======")
            }
            
            self.HeaderTableView.reloadData()
            print("====== crew 배열 count: \(self.crewInfo.count) ======")
        }
    }
    
    //MARK: - layout 및 초기 데이터 가져오기
    func viewLayout() {
        
        
        posterImageView.layer.borderWidth = 1
        posterImageView.layer.borderColor = UIColor.systemGray.cgColor
        posterImageView.layer.cornerRadius = 5
        
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.textColor = .white
        
    }
    
    func loadData() {
        
        guard let movieData = movieData else { return }
        
        title = movieData.title
        
        let url = URL(string: movieData.image)
        backgroundImageView.kf.setImage(with: url)
        backgroundImageView.contentMode = .scaleAspectFill
        
        let postUrl = URL(string: movieData.poster)
        posterImageView.kf.setImage(with: postUrl)
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.text = movieData.title
        
    }
}

//MARK: - TableViewController 관련 Protocol 채택
extension HeaderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crewInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = HeaderTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? HeaderTableViewCell else { return UITableViewCell() }
        
        
        cell.configCrewCell(data: crewInfo[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}



