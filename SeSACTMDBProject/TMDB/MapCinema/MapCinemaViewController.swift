//
//  MapCinemaViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/11.
//

import UIKit
import MapKit

class MapCinemaViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func filterButtonClicked(_ sender: UIButton) {
        let actionSheetAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheetAlert.addAction(UIAlertAction(title: "CGV", style: .default, handler: nil))
        actionSheetAlert.addAction(UIAlertAction(title: "메가박스", style: .default, handler: nil))
        actionSheetAlert.addAction(UIAlertAction(title: "롯데시네마", style: .default, handler: nil))
        actionSheetAlert.addAction(UIAlertAction(title: "전체보기", style: .default, handler: nil ))
        actionSheetAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheetAlert, animated: true, completion: nil)
    }
    

}
