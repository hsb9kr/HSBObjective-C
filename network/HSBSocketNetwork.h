//
//  HSBSocketNetwork.h
//  SocketDemo
//
//  Created by HongSang bo on 2016. 3. 22..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSBSocketNetwork : NSObject
@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;
@property (nonatomic) NSStringEncoding encoding;
-(instancetype) initSocketNetworkByStringHost:(NSString *) host port: (uint) port dataUsingEncoding:(NSStringEncoding) encoding;
-(instancetype) initSocketNetworkByURLHost:(NSURL *) host port: (uint) port dataUsingEncoding:(NSStringEncoding) encoding;
-(instancetype) initSocketNetworkByStringHost:(NSString *) host port: (uint) port;
-(instancetype) initSocketNetworkByURLHost:(NSURL *) host port: (uint) port;
-(void) setDelegate:(id) object;
-(NSInteger) writeWithString:(NSString *)string;
-(NSInteger)writeWithData:(NSData *)data;
@end
