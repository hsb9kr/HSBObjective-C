//
//  HSBJson.h
//  SocketDemo
//
//  Created by HongSang bo on 2016. 3. 22..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSBJson : NSObject
+(NSString *) getJsonStringWithObject:(id)object;
+(NSData *) getJsonDataWithObject:(id)object;
+(NSDictionary *) getJsonDictionaryWithString:(NSString *)jsonString;
+(NSDictionary *) getJsonDictionaryWithData:(NSData *)jsonData;
+(NSArray *) getJsonArrayWithString:(NSString *)jsonString;
+(NSArray *) getJsonArrayWithData:(NSData *)jsonData;
@end
