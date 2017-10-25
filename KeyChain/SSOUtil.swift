//
//  SSOUtil.swift
//  SecretCard(2.0)
//
//  Created by Sang bo Hong on 2017. 7. 16..
//  Copyright © 2017년 Sang bo Hong. All rights reserved.
//

import UIKit
import Security

// Keychain 관련 쿼리 키 값들
let kSecClassValue                  = NSString(format: kSecClass)
let kSecAttrAccountValue            = NSString(format: kSecAttrAccount)
let kSecValueDataValue              = NSString(format: kSecValueData)
let kSecAttrGenericValue            = NSString(format: kSecAttrGeneric)
let kSecAttrServiceValue            = NSString(format: kSecAttrService)
let kSecAttrAccessValue             = NSString(format: kSecAttrAccessible)
let kSecMatchLimitValue             = NSString(format: kSecMatchLimit)
let kSecReturnDataValue             = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue          = NSString(format: kSecMatchLimitOne)
let kSecAttrAccessGroupValue        = NSString(format: kSecAttrAccessGroup)
let kSecClassGenericPasswordValue   = NSString(format: kSecClassGenericPassword)

private let kCredentialTokenKey = "0d1j24u38m90duj8m419230d1k4u829n1203948"
private let kCredentialUsernameKey = "SecretCardUser"
private let kKeychainSSOGroup = "7C9772Q56V.com.hsb9kr.SecretCard"

class SSOUtil : NSObject {
    /**
     * Exposed methods to perform queries.
     * Note: feel free to play around with the arguments
     * for these if you want to be able to customise the
     * service identifier, user accounts, access groups, etc.
     */
    
    public class func saveToken(serviceIdentifier: String, userAccount: String, token: String) {
        self.save(service: serviceIdentifier, userAccount: userAccount, data: token)
    }
    
    public class func loadToken(serviceIdentifier: String, userAccount: String) -> String? {
        let token = self.load(service: serviceIdentifier, userAccount: userAccount)  
        return token
    }
    
    /**
     * Internal methods for querying the keychain.
     */
    private class func save(service: String, userAccount: String, data: String) {
        let dataFromString: Data = data.data(using: .utf8, allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new keychain item
        let status: OSStatus = SecItemAdd(keychainQuery as CFDictionary, nil)
        print(status)
    }
    
    private class func load(service: String, userAccount: String) -> String? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var retrievedData: NSData?
        var dataTypeRef:AnyObject?
        var contentsOfKeychain: String?
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        
        if (status == errSecSuccess) {
            retrievedData = dataTypeRef as? NSData
            contentsOfKeychain = String(data: retrievedData! as Data, encoding: .utf8)
        }
        else
        {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
}
