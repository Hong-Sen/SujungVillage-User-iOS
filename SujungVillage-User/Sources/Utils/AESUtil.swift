//
//  AESUtil.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/11.
//

import Foundation
import CryptoSwift

class AESUtil {
    
    // MARK: [클래스 설명]
    /*
    1. AES 암호화 란 비밀키를 사용해 인코딩 , 디코딩을 수행하는 암호화 기법입니다
    2. AES 128 [key] : 16 byte
    3. AES 192 [key] : 24 byte
    4. AES 256 [key] : 32 byte
    5. 필수 사항 : CryptoSwift 라이브러리 설치
    6. CryptoSwift 라이브러리 git 주소 : https://github.com/krzyzanowskim/CryptoSwift
    7. 패키지 import : import CryptoSwift
    */
    
    // MARK: [aes 인코딩 및 디코딩 key 값 지정]
    private let AES128_SECRET_KEY = "0123456789abcdef"
    //private let AES128_IV = "0123456789abcdef" // lv 지정
    private let AES128_IV = "" // lv null 지정
    
    private let AES192_SECRET_KEY = "0123456789abcdefghijklmn"
    //private let AES192_IV = "0123456789abcdef" // lv 지정
    private let AES192_IV = "" // lv null 지정
    
    private let AES256_SECRET_KEY = "0123456789abcdef0123456789abcdef"
    //private let AES256_IV = "0123456789abcdef" // lv 지정
    private let AES256_IV = "" // lv null 지정
    
    
    
    // MARK: [aes128 설정 값 지정 및 인코딩, 디코딩 메소드 지정]
    func getAES128Object() -> AES { // [설정 값]
        let keyDecodes : Array<UInt8> = Array(AES128_SECRET_KEY.utf8)
        var ivDecodes : Array<UInt8> = []
        if self.AES128_IV != "" || self.AES128_IV.count > 0 {
            ivDecodes = Array(AES128_IV.utf8)
        }
        else {
            ivDecodes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        }
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
        return aesObject
    }
    func setAES128Encrypt(string: String) -> String { // [인코딩]
        guard !string.isEmpty else { return "" }
        return try! self.getAES128Object().encrypt(string.bytes).toBase64()
    }
    func getAES128Decrypt(encoded: String) -> String { // [디코딩]
        let datas = Data(base64Encoded: encoded)
        guard datas != nil else {
            return ""
        }
        let bytes = datas!.bytes
        let decode = try! self.getAES128Object().decrypt(bytes)
        return String(bytes: decode, encoding: .utf8) ?? ""
    }
    
    
    
    // MARK: [aes192 설정 값 지정 및 인코딩, 디코딩 메소드 지정]
    func getAES192Object() -> AES { // [설정 값]
        let keyDecodes : Array<UInt8> = Array(AES192_SECRET_KEY.utf8)
        var ivDecodes : Array<UInt8> = []
        if self.AES192_IV != "" || self.AES192_IV.count > 0 {
            ivDecodes = Array(AES192_IV.utf8)
        }
        else {
            ivDecodes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        }
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
        return aesObject
    }
    func setAES192Encrypt(string: String) -> String { // [인코딩]
        guard !string.isEmpty else { return "" }
        return try! self.getAES192Object().encrypt(string.bytes).toBase64()
    }
    func getAES192Decrypt(encoded: String) -> String { // [디코딩]
        let datas = Data(base64Encoded: encoded)
        guard datas != nil else {
            return ""
        }
        let bytes = datas!.bytes
        let decode = try! self.getAES192Object().decrypt(bytes)
        return String(bytes: decode, encoding: .utf8) ?? ""
    }
    
    
    
    // MARK: [aes256 설정 값 지정 및 인코딩, 디코딩 메소드 지정]
    func getAES256Object() -> AES { // [설정 값]
        let keyDecodes : Array<UInt8> = Array(AES256_SECRET_KEY.utf8)
        var ivDecodes : Array<UInt8> = []
        if self.AES256_IV != "" || self.AES256_IV.count > 0 {
            ivDecodes = Array(AES256_IV.utf8)
        }
        else {
            ivDecodes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        }
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)
        return aesObject
    }
    func setAES256Encrypt(string: String) -> String { // [인코딩]
        guard !string.isEmpty else { return "" }
        return try! self.getAES256Object().encrypt(string.bytes).toBase64()
    }
    func getAES256Decrypt(encoded: String) -> String { // [디코딩]
        let datas = Data(base64Encoded: encoded)
        guard datas != nil else {
            return ""
        }
        let bytes = datas!.bytes
        let decode = try! self.getAES256Object().decrypt(bytes)
        return String(bytes: decode, encoding: .utf8) ?? ""
    }
    
}
