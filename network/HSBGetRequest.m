//
//  HSBGetRequest.m
//  OpenCV-test
//
//  Created by HongSang bo on 2016. 1. 7..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBGetRequest.h"

@interface HSBGetRequest()
@property (strong, nonatomic, readonly) NSMutableDictionary *params;
@property (strong, nonatomic, readonly) NSString *url;
@end
@implementation HSBGetRequest

-(instancetype)init{
    if (self = [super init]) {
        request = [[NSMutableURLRequest alloc] init];
        _params = [NSMutableDictionary new];
        _url = @"";
        [request setHTTPMethod:@"GET"];
        contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
        [request addValue:contentType forHTTPHeaderField:@"content-Type"];
        return self;
    }
    
    return nil;
}

-(instancetype)initAuthourizeByUserName : (NSString *)username password:(NSString *) password{
    if (self = [super init]) {
        NSString *authStr = [username stringByAppendingFormat:@":%@", password];
        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
        
        request = [[NSMutableURLRequest alloc] init];
        _params = [NSMutableDictionary new];
        _url = @"";
        [request setHTTPMethod:@"GET"];
        contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
        [request addValue:contentType forHTTPHeaderField:@"content-Type"];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
        
        return self;
    }
    
    return nil;
}

-(void)bindHttpBody{
    NSString *tmp = @"";
    for (NSString *key in _params) {
        tmp = [tmp isEqualToString:@""] ? [tmp stringByAppendingString:@"?"] : [tmp stringByAppendingString:@"&"];
        tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, _params[key]]];
    }
    tmp = [_url stringByAppendingString:tmp];
    [self setUrlOfRequestByString:tmp];
}

-(BOOL)isEmptyFromBody{
    if ([_params count] > 0) {
        return NO;
    }
    return YES;
}

-(void)clearBody{
    [_params removeAllObjects];
}

-(void)appendTextValueByKey:(NSString *)key value:(NSString *)value{
    [_params setObject:value forKey:key];
}

@end
