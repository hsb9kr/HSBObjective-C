//
//  HSBPostRequest.h
//  OpenCV-test
//
//  Created by HongSang bo on 2016. 1. 6..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSBRequest.h"

@interface HSBPostRequest : HSBRequest
@property (nonatomic) CGFloat imageCompressionQuality;

-(void)appendImageByKey:(NSString *)key name:(NSString *)name;
-(void)appendImageByKey:(NSString *)key name:(NSString *)name path:(NSString *)path;
-(void)appendData:(NSString *)key name:(NSString *)name data:(NSData *)data;
-(void)appendDataByKey : (NSString *) key name:(NSString *)name blk: (NSData * (^) (void)) blk;

@end
