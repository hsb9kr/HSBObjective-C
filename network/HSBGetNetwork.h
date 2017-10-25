//
//  HSBGetNetwork.h
//  BlueStamp
//
//  Created by HongSang bo on 2016. 8. 2..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSBGetNetwork : NSMutableURLRequest
- (void)setAuthourizeWithUserName: (NSString *)username password: (NSString *)password;
@end
