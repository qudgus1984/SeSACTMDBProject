//
//  MapCinemaViewController.swift
//  SeSACTMDBProject
//
//  Created by 이병현 on 2022/08/11.
//

import UIKit
import MapKit

// 1. 임포트
import CoreLocation

struct Theater {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
}

struct TheaterList {
    var mapAnnotations: [Theater] = [
        Theater(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        Theater(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        Theater(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        Theater(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        Theater(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        Theater(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
}




class MapCinemaViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // 2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    let cinemaList = TheaterList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. 프로토콜 연결
        locationManager.delegate = self
        // 시작할 때의 좌표 설정
        // 영등포 SeSAC 캠퍼스 37.517829, 126.886270
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        
        setRegionAndAnnotation(center: center)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        self.CGVAnnotation()
        self.megaAnnotation()
        self.lotteCinemaAnnotation()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //showRequestLocationServiceAlert()
        
    }
    
    func lotteCinemaAnnotation() {
        let lotteCinemaSeoul = MKPointAnnotation()
        lotteCinemaSeoul.coordinate = CLLocationCoordinate2D(latitude: cinemaList.mapAnnotations[0].latitude, longitude: cinemaList.mapAnnotations[0].longitude)
        lotteCinemaSeoul.title = cinemaList.mapAnnotations[0].location
        mapView.addAnnotation(lotteCinemaSeoul)
        let lotteCinemaGadi = MKPointAnnotation()
        lotteCinemaGadi.coordinate = CLLocationCoordinate2D(latitude: cinemaList.mapAnnotations[1].latitude, longitude: cinemaList.mapAnnotations[1].longitude)
        lotteCinemaGadi.title = cinemaList.mapAnnotations[1].location
        mapView.addAnnotation(lotteCinemaGadi)
    }
    
    func megaAnnotation() {
        let megaboxIsu = MKPointAnnotation()
        megaboxIsu.coordinate = CLLocationCoordinate2D(latitude: cinemaList.mapAnnotations[2].latitude, longitude: cinemaList.mapAnnotations[2].longitude)
        megaboxIsu.title = cinemaList.mapAnnotations[2].location
        mapView.addAnnotation(megaboxIsu)
        
        let megaboxGangNam = MKPointAnnotation()
        megaboxGangNam.coordinate = CLLocationCoordinate2D(latitude: cinemaList.mapAnnotations[3].latitude, longitude: cinemaList.mapAnnotations[3].longitude)
        megaboxGangNam.title = cinemaList.mapAnnotations[3].location
        mapView.addAnnotation(megaboxGangNam)
    }
    
    func CGVAnnotation() {
        let CGVYDP = MKPointAnnotation()
        CGVYDP.coordinate = CLLocationCoordinate2D(latitude: cinemaList.mapAnnotations[4].latitude, longitude: cinemaList.mapAnnotations[4].longitude)
        CGVYDP.title = cinemaList.mapAnnotations[4].location
        mapView.addAnnotation(CGVYDP)
        
        let CGVYS = MKPointAnnotation()
        CGVYS.coordinate = CLLocationCoordinate2D(latitude: cinemaList.mapAnnotations[5].latitude, longitude: cinemaList.mapAnnotations[5].longitude)
        CGVYS.title = cinemaList.mapAnnotations[5].location
        mapView.addAnnotation(CGVYS)
        
    }
    
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        
        let actionSheetAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let CGV = UIAlertAction(title: "CGV", style: .default) { action in
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            self.CGVAnnotation()
        }
        let megaBox = UIAlertAction(title: "메가박스", style: .default) { action in
            
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            self.megaAnnotation()
        }
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { action in
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            self.lotteCinemaAnnotation()
            
        }
        let total = UIAlertAction(title: "전체보기", style: .default) { action in
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            self.CGVAnnotation()
            self.megaAnnotation()
            self.lotteCinemaAnnotation()
            
        }
        actionSheetAlert.addAction(CGV)
        actionSheetAlert.addAction(megaBox)
        actionSheetAlert.addAction(lotteCinema)
        actionSheetAlert.addAction(total)
        actionSheetAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheetAlert, animated: true, completion: nil)
    }
    
    
}

extension MapCinemaViewController {
    // Location7. iOS 버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부
    // 위치 서비스가 켜져 있다면 권한을 요청하고, 꺼져 있다면 커스텀 얼럿으로 상황 알려주기
    // CLAuthorizationStatus
    // -denied: 허용 안함 / 설정에서 추후에 거부 / 위치 서비스 중지 / 비행기 모드
    // - restricted : 앱 권한 자체 없는 경우 / 자녀 보호 기능 같은걸로 아예 제한
    func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            // 프로퍼티를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치 서비스 활성화 여부 체크 : locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
            checkUserCurrentLocationAuthorization(authorizationStatus)
            
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못함")
        }
        
    }
    
    // Location8. 사용자의 위치 권한 상태 확인
    // 사용자가 위치를 허용했는 지, 거부했는 지, 아직 선택하지 않앗는 지 등을 확인. (단, 사전에 iOS 위치 서비스 활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOTDETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            //plist WhenInUse -> request 메서드 OK
//            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            // 사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
        default: print("DEFAULT")

        }
    }
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
        
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }

}

// Location4. 프로토콜 선언
extension MapCinemaViewController: CLLocationManagerDelegate {

    // Location5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        // ex. 위도, 경도 기반으로 날씨 정보를 조회
        // ex. 지도를 다시 세팅
        
        if let coordinate = locations.last?.coordinate {

            
            setRegionAndAnnotation(center: coordinate)

        }
        
        //위치 업데이트 멈춰!!
        locationManager.stopUpdatingLocation()
    }
    
    // Location6. 사용자의 위치를 가져오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)

    }
    
    // Location9. 사용자의 권한 상태가 바뀔 때를 알려줌
    // 거부 했다가 설정에서 변경했거나, 혹은 notDetermined에서 허용을 했거나 등
    // 허용 했어서 위치를 가지고 오는 중에, 설정에서 거부하고 돌아온다면?
    
    // iOS 14 이상: 사용자의 군한 상태가 변경이 될 때, 위치 관리자 생성할 때 호출됨.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
