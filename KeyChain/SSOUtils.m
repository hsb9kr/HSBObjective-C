//
//  SSOUtils.m
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import "SSOUtils.h"
#import <Security/Security.h>

// replace "BUSUJW9XLQ" with your own bundle seed ID
#define kKeychainSSOGroup			@"JD8T662RZF.com.localmarketingpartners.KeychainTest"
#define kCredentialTokenKey			@"SSOAuthenticationToken"
#define kCredentialUsernameKey		@"SSOAuthenticationUsername"

@interface SSOUtils(Private)


+ (NSMutableDictionary*)keychainSearch:(NSString*)identifier;
+ (NSString*)getValueForIdentifier:(NSString*)identifer;
+ (BOOL)setValue:(NSString *)value forIdentifier:(NSString*)identifier;
+ (BOOL)deleteValueForIdentifier:(NSString*)identifier;

@end


@implementation SSOUtils

+ (BOOL)authenticateWithUsername:(NSString *)username andPassword:(NSString *)password {
	// you should do a check of the given credentials here
	// this dummy application will always return a successful login
	BOOL loginResult = YES;
	
	if (loginResult == YES) {
		// set SSO username
		[self setValue:username	forIdentifier:kCredentialUsernameKey];
        
		
		// set SSO token
		[self setValue:@"SSOValidToken" forIdentifier:kCredentialTokenKey];
	}
	
    return loginResult;
}

+ (void)logout {
    // destroy the saved token
    [self deleteValueForIdentifier:kCredentialTokenKey];
}

+ (BOOL)credentialsAreValid {
    NSString *token = [self credentialToken];
    
	if (token == nil) {
		return NO;
	}
    
    // you should do a secure check of the token here
	// we'll do a dummy check to make sure it matches our secret value 'SSOValidToken'
    return [token isEqualToString:@"SSOValidToken"];
}

+ (NSString*)credentialToken {
    return [self getValueForIdentifier:kCredentialTokenKey];
}

+ (NSString *)credentialUsername {
	return [self getValueForIdentifier:kCredentialUsernameKey];
}


#pragma mark - Keychain Manipulation

+ (NSMutableDictionary*)keychainSearch:(NSString*)identifier {
	NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *keychainSearch = [[NSMutableDictionary alloc] init];
	
	// set the type to generic password
    [keychainSearch setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
	
	// set the item's identifier
    [keychainSearch setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [keychainSearch setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [keychainSearch setObject:encodedIdentifier forKey:(__bridge id)kSecAttrService];
    
    [keychainSearch setObject:(__bridge  id)kSecAttrAccessibleAlways forKey:(__bridge id)kSecAttrAccessible];
    
	// use the shared keychain
	// note: not supported in the simulator and will cause all keychain calls to fail
	#if !(TARGET_IPHONE_SIMULATOR)
		[keychainSearch setObject:kKeychainSSOGroup forKey:(__bridge id)kSecAttrAccessGroup];
	#endif
	
    return keychainSearch;
}

+ (NSString*)getValueForIdentifier:(NSString*)identifier {
    NSMutableDictionary *search = [self keychainSearch:identifier];
	
	// limit to the first result
    [search setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
	
	// return data vs a dictionary of attributes
    [search setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
	
	// perform the search

    CFTypeRef dataTypeRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)search, &dataTypeRef);
    NSData *value = (__bridge NSData *)dataTypeRef;
    
    if (status == noErr && [value bytes]) {
        return [NSString stringWithUTF8String:[value bytes]];
    }
    
    return nil;
}

+ (BOOL)setValue:(NSString*)value forIdentifier:(NSString*)identifier {
    NSString *existingValue = [self getValueForIdentifier:identifier];
	
	// check if value exists
    if (existingValue) {
		
		// update if the new value is different
        if (![existingValue isEqualToString:value]) {
            NSMutableDictionary *search = [self keychainSearch:identifier];
            NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *update = [NSMutableDictionary dictionaryWithObjectsAndKeys:valueData, (__bridge id)kSecValueData, nil];
            
            OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)search,
                                            (__bridge CFDictionaryRef)update);
            
            if (status == errSecSuccess) {
                return YES;
            }
			
            return NO;
        
		} else {
			return YES;
		}
        
	// if no value exists, create a new entry
    } else {
        NSMutableDictionary *add = [self keychainSearch:identifier];
        NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
        [add setObject:valueData forKey:(id)kSecValueData];
        NSLog(@"%@", add);
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)add , NULL);
        NSLog(@"%d", status);
        if (status == errSecSuccess) {
            return YES;
        }
		
        return NO;
    }
}

+ (BOOL)deleteValueForIdentifier:(NSString*)identifier {
    NSMutableDictionary *search = [self keychainSearch:identifier];

    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)search);

	if (status == errSecSuccess) {
		return YES;
	}

	return NO;
}

@end