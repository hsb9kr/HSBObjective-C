//
//  HSBRequest.m
//  BlueStamp
//
//  Created by HongSang bo on 2016. 4. 20..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBRequest.h"

@implementation HSBRequest
@synthesize session, request, requestState, contentType;
-(instancetype)init{
    self = [super init];
    if (self) {
        request = [[NSMutableURLRequest alloc] init];
        session = [NSURLSession sharedSession];
        requestState = RequestServiceAvailable;
    }
    
    return self;
}

-(instancetype)initAuthourizeByUserName : (NSString *)username password:(NSString *) password{
    return [self init];
}
-(void)setUrlOfRequestByString:(NSString *) url{
    [request setURL:[NSURL URLWithString:url]];
}

-(void)setUrlOfRequestByURL:(NSURL *) url{
    [request setURL:url];
}

-(void)bindHttpBody{
    [NSException raise:@"Invoked abstract bindHttpBody" format:@"Invoked abstract method"];
    return;
}

-(BOOL)isEmptyFromBody{
    [NSException raise:@"Invoked abstract isEmptyFromBody" format:@"Invoked abstract method"];
    return nil;
}

-(void)clearBody{
    [NSException raise:@"Invoked abstract clearBody" format:@"Invoked abstract method"];
}

-(void)appendTextValueByKey:(NSString *)key value:(NSString *)value{
    [NSException raise:@"Invoked abstract appendTextValueByKey" format:@"Invoked abstract method"];
}

-(void) connectionWithCompletionHandlerWithError: (void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler{
    NSURLSessionDataTask *dataTask = nil;
    [self bindHttpBody];
    dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(data, response, error);
            requestState = RequestServiceAvailable;
        });
        
        [self clearBody];
        
    }];
    switch (requestState) {
        case RequestServiceAvailable:
            [dataTask resume];
            break;
        case RequestServiceNonAvailable:
            
            break;
    }
    requestState = RequestServiceNonAvailable;
}

-(void) connectionWithCompletionHandler: (void (^)(NSData * data, NSURLResponse * response))completionHandler completion:(void (^) (void)) completion;{
    NSURLSessionDataTask *dataTask = nil;
    [self bindHttpBody];
    dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                
            }else{
                completionHandler(data, response);
                requestState = RequestServiceAvailable;
            }
        });
        if (completion != nil) {
            completion();
            [self clearBody];
        }
    }];
    switch (requestState) {
        case RequestServiceAvailable:
            [dataTask resume];
            break;
        case RequestServiceNonAvailable:
            
            break;
    }
    requestState = RequestServiceNonAvailable;
}

-(void) connectionWithTimeWithError:(CGFloat) time completionHandler: (void (^)(NSData * data, NSURLResponse * response, NSError * error))completionHandler{
    
    NSURLSessionDataTask *dataTask = nil;
    session.configuration.timeoutIntervalForRequest = time;
    [self bindHttpBody];
    dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        completionHandler(data, response, error);
        [self clearBody];
        requestState = RequestServiceAvailable;
    }];
    switch (requestState) {
        case RequestServiceAvailable:
            [dataTask resume];
            break;
        case RequestServiceNonAvailable:
            
            break;
    }
    requestState = RequestServiceNonAvailable;
}

-(void) connectionWithTime:(CGFloat) time completionHandler: (void (^)(NSData * data, NSURLResponse * response))completionHandler completion:(void (^) (void)) completion;{
    
    NSURLSessionDataTask *dataTask = nil;
    session.configuration.timeoutIntervalForRequest = time;
    [self bindHttpBody];
    dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                
            }else{
                completionHandler(data, response);
                requestState = RequestServiceAvailable;
            }
            if (completion != nil) {
                completion();
                [self clearBody];
                requestState = RequestServiceAvailable;
            }
        });
    }];
    switch (requestState) {
        case RequestServiceAvailable:
            [dataTask resume];
            break;
        case RequestServiceNonAvailable:
            
            break;
    }
    requestState = RequestServiceNonAvailable;
}
@end
