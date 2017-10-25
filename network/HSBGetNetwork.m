//
//  HSBGetNetwork.m
//  BlueStamp
//
//  Created by HongSang bo on 2016. 8. 2..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBGetNetwork.h"

@interface HSBGetNetwork()
@property (strong, nonatomic, readonly) NSMutableDictionary *params;
@property (strong, nonatomic, readonly) NSString *url;
@property (strong, nonatomic) NSString *contentType;
@end

@implementation HSBGetNetwork

#pragma mark - initialize
- (instancetype)initWithURL:(NSURL *)URL{
    self = [super initWithURL:URL];
    if (self) {
        [self defaultInitialize];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval{
    self = [super initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    if (self) {
        [self defaultInitialize];
    }
    return self;
}

- (void) defaultInitialize{
    [self setHTTPMethod:@"GET"];
}

#pragma mark - public methods

- (void) setAuthourizeWithUserName: (NSString *)username password: (NSString *)password{
    NSString *authStr = [username stringByAppendingFormat:@":%@", password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    _contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    [self addValue:_contentType forHTTPHeaderField:@"content-Type"];
    [self setValue:authValue forHTTPHeaderField:@"Authorization"];
}
@end
