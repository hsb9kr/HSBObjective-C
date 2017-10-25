//
//  String+SecretCard.swift
//  SecretCard(2.0)
//
//  Created by hsb9kr on 2017. 7. 17..
//  Copyright © 2017년 Sang bo Hong. All rights reserved.
//

import Foundation
private let key = "c780a841926a20ed15d97cfa7097ceab"

extension String {
    enum HMACAlgorithm {
        case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
        
        func toCCHmacAlgorithm() -> CCHmacAlgorithm {
            var result: Int = 0
            switch self {
            case .MD5:
                result = kCCHmacAlgMD5
            case .SHA1:
                result = kCCHmacAlgSHA1
            case .SHA224:
                result = kCCHmacAlgSHA224
            case .SHA256:
                result = kCCHmacAlgSHA256
            case .SHA384:
                result = kCCHmacAlgSHA384
            case .SHA512:
                result = kCCHmacAlgSHA512
            }
            return CCHmacAlgorithm(result)
        }
        
        func digestLength() -> Int {
            var result: CInt = 0
            switch self {
            case .MD5:
                result = CC_MD5_DIGEST_LENGTH
            case .SHA1:
                result = CC_SHA1_DIGEST_LENGTH
            case .SHA224:
                result = CC_SHA224_DIGEST_LENGTH
            case .SHA256:
                result = CC_SHA256_DIGEST_LENGTH
            case .SHA384:
                result = CC_SHA384_DIGEST_LENGTH
            case .SHA512:
                result = CC_SHA512_DIGEST_LENGTH
            }
            return Int(result)
        }
    }

    func md5() -> String {
        return hmac(algorithm: .MD5, key: key)
    }
    
    func sha1() -> String {
        return hmac(algorithm: .SHA1, key: key)
    }
    
    func sha224() -> String {
        return hmac(algorithm: .SHA224, key: key)
    }
    
    func sha256() -> String {
        return hmac(algorithm: .SHA256, key: key)
    }
    
    func sha384() -> String {
        return hmac(algorithm: .SHA384, key: key)
    }
    
    func sha512() -> String {
        return hmac(algorithm: .SHA512, key: key)
    }
    
    private func hmac(algorithm: HMACAlgorithm, key: String) -> String {
        let cKey = key.cString(using: String.Encoding.utf8)
        let cData = self.cString(using: String.Encoding.utf8)
        var result = [CUnsignedChar](repeating: 0, count: Int(algorithm.digestLength()))
        CCHmac(algorithm.toCCHmacAlgorithm(), cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &result)
        let hmacData:NSData = NSData(bytes: result, length: (Int(algorithm.digestLength())))
        let hmacBase64 = hmacData.base64EncodedString(options: .lineLength64Characters)
        return String(hmacBase64)
    }
}
