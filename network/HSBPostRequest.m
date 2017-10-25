//
//  HSBPostRequest.m
//  OpenCV-test
//
//  Created by HongSang bo on 2016. 1. 6..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBPostRequest.h"

static const NSString *boundary = @"---------------------------14737809831466499882746641449";

@interface HSBPostRequest ()
@property (strong, nonatomic, readonly) NSMutableData *body;
@end

@implementation HSBPostRequest

-(instancetype)init{
    if (self = [super init]) {
        _body = [NSMutableData data];
        
        [request setHTTPMethod:@"POST"];
        contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
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
        _body = [NSMutableData data];

        [request setHTTPMethod:@"POST"];
        contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField:@"content-Type"];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
        return self;
    }

    return nil;
}

-(void)bindHttpBody{
    [request setHTTPBody:_body];
}

-(BOOL)isEmptyFromBody{
    if ([_body length] > 0) {
        return NO;
    }
    return YES;
}

-(void)clearBody{
    [_body replaceBytesInRange:NSMakeRange(0, [_body length]) withBytes:nil length:0];
}

-(void)appendTextValueByKey:(NSString *)key value:(NSString *)value{
    [_body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [_body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@", key, value] dataUsingEncoding:NSUTF8StringEncoding]];
}

-(void)appendImageByKey:(NSString *)key name:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    NSData *data = UIImageJPEGRepresentation(image, _imageCompressionQuality);
    [self appendDataByKey:key name:name data:data];
}

-(void)appendImageByKey:(NSString *)key name:(NSString *)name path:(NSString *)path{
    UIImage *image = [UIImage imageWithContentsOfFile:[path stringByAppendingString:name]];
    NSData *data = UIImageJPEGRepresentation(image, _imageCompressionQuality);
    [self appendDataByKey:key name:name data:data];
}

-(void)appendData:(NSString *)key name:(NSString *)name data:(NSData *)data{
    [self appendDataByKey:key name:name data:data];
}

-(void) appendDataByKey : (NSString *) key name:(NSString *)name data:(NSData *)data{
    [_body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [_body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, name] dataUsingEncoding:NSUTF8StringEncoding]];
    [_body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [_body appendData:[NSData dataWithData:data]];
}

-(void) appendDataByKey : (NSString *) key name:(NSString *)name blk: (NSData*  (^) (void)) blk{
    NSData *data = blk();
    [_body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [_body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", key, name] dataUsingEncoding:NSUTF8StringEncoding]];
    [_body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [_body appendData:[NSData dataWithData:data]];
}

@end
