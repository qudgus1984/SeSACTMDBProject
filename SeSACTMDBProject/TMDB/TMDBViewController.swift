//
//  TMDBViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/04.
//

import UIKit

class TMDBViewController: UIViewController {

    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        CollectionView.dataSource = self
        CollectionView.delegate = self
        

    }
    



}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TMDBCollectionViewCell", for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }
}
