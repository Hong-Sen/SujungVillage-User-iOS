//
//  PBKDF2Util.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2023/06/21.
//

import Foundation
import CommonCrypto

class PBKDF2 {
    let salt = Data(bytes: [0x73, 0x61, 0x6c, 0x74, 0x44, 0x61, 0x74, 0x61])
    let msec = 100
    
    func pbkdf2SHA1Calibrate(password: String) -> UInt32 {
        let actualRoundCount: UInt32 = CCCalibratePBKDF(
            CCPBKDFAlgorithm(kCCPBKDF2),
            password.utf8.count,
            salt.count,
            CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1),
            kCCKeySizeAES256,
            UInt32(msec))
        
        return actualRoundCount
    }
}
