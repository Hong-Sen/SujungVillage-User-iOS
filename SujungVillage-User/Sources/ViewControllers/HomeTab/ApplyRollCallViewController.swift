//
//  ApplyRollCallViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/06.
//

import UIKit
import CoreLocation

class ApplyRollCallViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cameraAreaImg: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var refreshLabel: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var refreshView: UIView!
    let imagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    private var photoArr: Array<UInt8> = []
    private var finalLocation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setImagePicker()
        setLocationManager()
    }
    
    func setUI(){
        locationLabel.text = "현재 위치"
        locationLabel.font = UIFont.suit(size: 15, family: .Medium)
        locationLabel.textColor = UIColor(hexString: "434343")
        
        refreshLabel.text = "위치 새로고침"
        refreshLabel.font = UIFont.suit(size: 15, family: .Medium)
        refreshLabel.textColor = UIColor.primary
        
        submitBtn.setTitle("제출하기", for: .normal)
        submitBtn.setTitleColor(.white, for: .normal)
        submitBtn.titleLabel?.font = UIFont.suit(size: 30, family: .Bold)
        submitBtn.tintColor = UIColor.primary
        
        cameraAreaImg.isUserInteractionEnabled = true
        cameraAreaImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cameraAreaTapped)))
        refreshView.isUserInteractionEnabled = true
        refreshView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.refreshViewTapped)))
    }
    
    private func setImagePicker() {
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
    }
    
    private func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    @objc func cameraAreaTapped(sender: UITapGestureRecognizer) {
        self.imagePicker.sourceType = .camera // simulator 작동시 오류(test시 .photoLibrary로 변경)
        //        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.modalPresentationStyle = .overFullScreen
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc func refreshViewTapped(sender: UITapGestureRecognizer) {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        else {
            print("위치 서비스 허용 off")
        }
    }
    
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnSelcetd(_ sender: Any) {
        if photoArr.isEmpty && finalLocation == "" {
            let alert = UIAlertController(title: "사진과 위치를 추가해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        else if photoArr.isEmpty {
            let alert = UIAlertController(title: "점호사진을 촬영해 주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        else if finalLocation == "" {
            let alert = UIAlertController(title: "현재 위치정보가 없습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        Repository.shared.applyRollCall(image: photoArr, location: finalLocation) { status, rollcallResponse in
            switch status {
            case .ok:
                print("점호 제출 완료")
            default:
                print("error: \(status)")
                break
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension ApplyRollCallViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func toByteArray<T>(_ value: T) -> [UInt8] {
        var value = value
        return withUnsafeBytes(of: &value) { Array($0) }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            cameraAreaImg.image = image
            guard let data = image.jpegData(compressionQuality: 1.0) else { return }
            let byteArray = toByteArray(data)
            photoArr = byteArray
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ApplyRollCallViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longtitude = location.coordinate.longitude
            
            let findLocation = CLLocation(latitude: latitude, longitude: longtitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: { [self](placemarks, error) in
                var address = ""
                if let placemark = placemarks?.first {
                    if let administrativeArea = placemark.administrativeArea { //서울특별시
                        address = "\(administrativeArea) "
                    }
                    
                    if let locality = placemark.subLocality { //광진구
                        address = "\(address) \(locality) "
                    }
                    
                    if let thoroughfare = placemark.thoroughfare {  //중곡동
                        address = "\(address) \(thoroughfare) "
                    }
                    
                    if let subThoroughfare = placemark.subThoroughfare { //272-13
                        address = "\(address) \(subThoroughfare)"
                    }
                }
                print(address) //서울특별시 광진구 중곡동 272-13
                self.locationLabel.text = address
                finalLocation = address
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
