//
//  HSBPostNetwork.h
//  BlueStamp
//
//  Created by HongSang bo on 2016. 8. 2..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>
static const NSString *boundary = @"---------------------------14737809831466499882746641449";
@interface HSBPostNetwork : NSMutableURLRequest
@property (strong, nonatomic) NSString *contentType;
@property (strong, nonatomic, readonly) NSMutableData *body;
@property (nonatomic) CGFloat imageCompressionQuality;

- (void)setAuthourizeWithUserName:(NSString *)username password:(NSString *)password;
- (void)bindHttpBody;
- (void)clearBody;
- (BOOL)isEmptyFromBody;
- (void)appendTextValueByKey:(NSString *)key value:(NSString *)value;
- (void)appendImageByKey:(NSString *)key name:(NSString *)name;
- (void)appendImageByKey:(NSString *)key name:(NSString *)name path:(NSString *)path;
- (void)appendData:(NSString *)key name:(NSString *)name data:(NSData *)data;
- (void)appendDataByKey:(NSString *)key name:(NSString *)name blk: (NSData * (^) (void))blk;
- (void)connectionWithCompletionHandler:(void (^)(NSURLResponse * response, NSData * data, NSError * error))completionHandler completion:(void (^) (void))completion error:(void (^) (void))errorMethod;
@end
