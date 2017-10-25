//
//  InfoCoreData.h
//  TPM
//
//  Created by HongSang bo on 2016. 3. 10..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBDataManage.h"
@class Info;
@interface InfoCoreData : HSBDataManage

-(BOOL) insertInfoAutoSignIn: (BOOL) isAutoSignIn userkey: (NSString *)userkey signInToken: (NSString *) signInToken email: (NSString *)email;
-(BOOL) updateInfoAutoSignIn: (BOOL) isAutoSignIn userkey: (NSString *)userkey signInToken: (NSString *) signInToken email: (NSString *)email;
-(Info *) getInfo;
-(BOOL) deleteInfo;
@end
