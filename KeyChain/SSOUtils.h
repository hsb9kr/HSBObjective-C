//
//  SSOUtils.h
//  Employee Directory
//
//  Copyright (c) 2012 John Szumski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSOUtils : NSObject

+ (BOOL)authenticateWithUsername:(NSString *)username andPassword:(NSString *)password;
+ (void)logout;

+ (BOOL)credentialsAreValid;
+ (NSString *)credentialToken;
+ (NSString *)credentialUsername;
+ (BOOL)setValue:(NSString*)value forIdentifier:(NSString*)identifier;
+ (NSString*)getValueForIdentifier:(NSString*)identifier;
+ (BOOL)deleteValueForIdentifier:(NSString*)identifier;
@end