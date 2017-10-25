//
//  HSBSocketNetwork.m
//  SocketDemo
//
//  Created by HongSang bo on 2016. 3. 22..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBSocketNetwork.h"
@implementation HSBSocketNetwork

#pragma mark - init
-(instancetype) initSocketNetworkByStringHost:(NSString *) host port: (uint) port dataUsingEncoding:(NSStringEncoding) encoding{
    self = [super init];
    if (self) {
        [self initSocketNetworkByHost:host port:port];
        _encoding = encoding;
    }
    
    return self;
}

-(instancetype) initSocketNetworkByURLHost:(NSURL *) host port: (uint) port dataUsingEncoding:(NSStringEncoding) encoding{
    self = [super init];
    if (self) {
        _encoding = encoding;
    }
    return self;
}

-(instancetype) initSocketNetworkByStringHost:(NSString *) host port: (uint) port{
    self = [super init];
    if (self) {
        [self initSocketNetworkByHost:host port:port];
        _encoding = NSUTF8StringEncoding;
    }
    
    return self;
}

-(instancetype) initSocketNetworkByURLHost:(NSURL *) host port: (uint) port{
    self = [super init];
    if (self) {
        _encoding = NSUTF8StringEncoding;
    }
    return self;
}

-(void) initSocketNetworkByHost:(NSString *)host port: (uint) port{
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);
    
    _inputStream = (__bridge NSInputStream *)readStream;
    _outputStream = (__bridge NSOutputStream *)writeStream;
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    [_outputStream open];
}

-(void) setDelegate:(id) object{
    [_inputStream setDelegate:object];
    [_outputStream setDelegate:object];
}

#pragma mark - SocketNetwork

-(NSInteger)writeWithString:(NSString *)string{
    NSData *data = [[NSData alloc] initWithData:[string dataUsingEncoding:_encoding]];

    return [_outputStream write:[data bytes] maxLength:[data length]];
}

-(NSInteger)writeWithData:(NSData *)data{
    return [_outputStream write:[data bytes] maxLength:[data length]];
}

@end
