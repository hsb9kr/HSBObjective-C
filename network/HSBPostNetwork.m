//
//  HSBPostNetwork.m
//  BlueStamp
//
//  Created by HongSang bo on 2016. 8. 2..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBPostNetwork.h"

@interface HSBPostNetwork ()
@property (strong, nonatomic) NSString *params;
@end

@implementation HSBPostNetwork
@synthesize body = _body;
@synthesize contentType = _contentType;
@synthesize imageCompressionQuality = _imageCompressionQuality;
@synthesize params = _params;

#pragma mark - initialize

- (instancetype)initWithURL:(NSURL *)URL {
    self = [super initWithURL:URL];
    if (self) {
        [self defaultInitialize];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval {
    self = [super initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    if (self) {
        [self defaultInitialize];
    }
    return self;
}

- (void)defaultInitialize {
    _body = [NSMutableData data];
    _params = @"";
    [self setHTTPMethod:@"POST"];
    _contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [self addValue:_contentType forHTTPHeaderField:@"content-Type"];
}

#pragma mark - public methods

- (void)setAuthourizeWithUserName:(NSString *)username password:(NSString *)password {
    NSString *authStr = [username stringByAppendingFormat:@":%@", password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    [self defaultInitialize];
    [self setValue:authValue forHTTPHeaderField:@"Authorization"];
}

- (void)bindHttpBody {
    [self.body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self setHTTPBody:_body];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[_body length]];
    [self setValue:postLength forHTTPHeaderField:@"Content-Length"];
}

- (BOOL)isEmptyFromBody {
    if ([_body length] > 0) {
        return NO;
    }
    return YES;
}

- (void)clearBody {
    [self.body replaceBytesInRange:NSMakeRange(0, [_body length]) withBytes:nil length:0];
}

- (void)appendTextValueByKey:(NSString *)key value:(NSString *)value {
    if (!value) {
        value = @"";
    }
    self.params = [_params stringByAppendingFormat:@"%@=%@&", key, value];
    [self.body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", key, value] dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)appendImageByKey:(NSString *)key name:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    NSData *data = UIImageJPEGRepresentation(image, _imageCompressionQuality);
    [self appendDataByKey:key name:name data:data];
}

- (void)appendImageByKey:(NSString *)key name:(NSString *)name path:(NSString *)path {
    UIImage *image = [UIImage imageWithContentsOfFile:[path stringByAppendingString:name]];
    NSData *data = UIImageJPEGRepresentation(image, _imageCompressionQuality);
    [self appendDataByKey:key name:name data:data];
}

- (void)appendData:(NSString *)key name:(NSString *)name data:(NSData *)data {
    [self appendDataByKey:key name:name data:data];
}

- (void)appendDataByKey:(NSString *)key name:(NSString *)name data:(NSData *)data {
    [self.body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, name] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[NSData dataWithData:data]];
    [self.body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)appendDataByKey:(NSString *)key name:(NSString *)name blk:(NSData*  (^) (void))blk {
    NSData *data = blk();
    [self.body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, name] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [self.body appendData:[NSData dataWithData:data]];
}

- (void) connectionWithCompletionHandler: (void (^)(NSURLResponse * response, NSData * data, NSError * error)) completionHandler completion:(void (^) (void)) completion error : ( void (^) (void)) errorMethod {
    [[[NSURLSession sharedSession] dataTaskWithRequest:self completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (errorMethod != nil) {
                    errorMethod();
                }
            } else if (completionHandler) {
                completionHandler(response, data, error);
            }
            
            if (completion != nil) {
                completion();
            }
            [self clearBody];
        });
    }] resume];
}

- (NSString *)description {
    return [self.URL.absoluteString stringByAppendingFormat:@"?%@", _params];
}

@end
