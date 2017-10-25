//
//  HSBRequest.h
//  BlueStamp
//
//  Created by HongSang bo on 2016. 4. 20..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RequestServiceAvailable
    ,RequestServiceNonAvailable
}RequestState;

typedef enum {
    FirstConnection
    ,NormalConnection
}ConnectionState;

@interface HSBRequest : NSObject{
    @protected NSString *contentType;
    @protected NSMutableURLRequest *request;
    @protected NSURLSession *session;
    @protected RequestState requestState;
}

@property (strong, nonatomic, readonly) NSString *contentType;
@property (strong, nonatomic, readonly) NSMutableURLRequest *request;
@property (strong, nonatomic, readonly) NSURLSession *session;
@property (nonatomic) RequestState requestState;

-(instancetype)initAuthourizeByUserName : (NSString *)username password:(NSString *) password;
-(void)setUrlOfRequestByString:(NSString *) url;
-(void)setUrlOfRequestByURL:(NSURL *) url;
-(void)bindHttpBody;
-(void)clearBody;
-(BOOL)isEmptyFromBody;
-(void)appendTextValueByKey:(NSString *)key value:(NSString *)value;
-(void) connectionWithCompletionHandlerWithError: (void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler;
-(void) connectionWithCompletionHandler: (void (^)(NSData * data, NSURLResponse * response))completionHandler completion:(void (^) (void)) completion;;
-(void) connectionWithTimeWithError:(CGFloat) time completionHandler: (void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler;
-(void) connectionWithTime:(CGFloat) time completionHandler: (void (^)(NSData * data, NSURLResponse * response))completionHandler completion:(void (^) (void)) completion;
@end
