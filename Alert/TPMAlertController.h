//
//  TPMAlertController.h
//  TPM
//
//  Created by HongSang bo on 2016. 2. 12..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPMAlertController : UIAlertController
+(instancetype)initCustomAlertController:(NSString *)title message:(NSString *) message;
+(instancetype)initFollowCancelAlertController;
+(instancetype)initInCorrectAccountInfoAlertController;
-(void) addActionWithYes:(void (^) (void)) blk;
-(void) addActionWithNo:(void (^) (void)) blk;
@end
