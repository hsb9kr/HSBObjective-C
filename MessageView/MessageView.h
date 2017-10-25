//
//  MessageViewArea.h
//  OpenCV-test
//
//  Created by HongSang bo on 2015. 12. 11..
//  Copyright © 2015년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HSBKeyboard.h"

static const CGFloat sendBtnWidth = 48.f;
static const CGFloat sendBtnHeight = 30.f;
static const CGFloat textViewHeight = 30.f;
static const CGFloat height = 40.f;
static const CGFloat textFont = 15.f;

@interface MessageView : UIView

@property (strong, nonatomic) UITextView *msgTextView;
@property (strong, nonatomic) UIButton *msgSendBtn;
@property (nonatomic) CGFloat y;
@property (nonatomic) NSInteger lines;

-(void) viewWillAppearLine;

-(void)showKeyboardWithHeight:(CGFloat) height;
-(void)hideKeyboardWithHeight:(CGFloat) height;
@end
