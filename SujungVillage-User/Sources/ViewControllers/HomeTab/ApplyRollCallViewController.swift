//
//  ApplyRollCallViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/06.
//

import UIKit

class ApplyRollCallViewController: UIViewController {
    
    @IBOutlet weak var cameraAreaImg: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var refreshLabel: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var refreshView: UIView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
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
        submitBtn.titleLabel?.font = UIFont.suit(size: 18, family: .Bold)
        submitBtn.tintColor = UIColor.primary
        
        cameraAreaImg.isUserInteractionEnabled = true
        cameraAreaImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cameraAreaTapped)))
    }
    
    @objc func cameraAreaTapped(sender: UITapGestureRecognizer) {
        self.imagePicker.sourceType = .camera // simulator 작동시 오류(test시 .photoLibrary로 변경)
        self.imagePicker.modalPresentationStyle = .overFullScreen
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnSelcetd(_ sender: Any) {
        //
    }
}

extension ApplyRollCallViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func getArrayOfBytesFromImage(imageData:NSData) -> Array<UInt8> {
        let count = imageData.length / MemoryLayout<Int8>.size
        var bytes = [UInt8](repeating: 0, count: count)
        imageData.getBytes(&bytes, length:count * MemoryLayout<Int8>.size)
        var byteArray:Array = Array<UInt8>()
        for i in 0 ..< count {
            byteArray.append(bytes[i])
        }
        return byteArray
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            cameraAreaImg.image = image
            guard let data = image.jpegData(compressionQuality: 1.0) else { return }
            let byteArray = getArrayOfBytesFromImage(imageData: data as NSData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
