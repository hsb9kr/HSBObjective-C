//
//  MessageTableView.h
//  OpenCV-test
//
//  Created by HongSang bo on 2015. 12. 11..
//  Copyright © 2015년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *CellIdentifier = @"CellIdentifier";

@interface MessageTableView : UITableView

@property (nonatomic) CGFloat height;
-(instancetype) initWithFrame: (CGRect) frame MessageViewWithFrame : (CGRect) mvFrame;
-(void)viewWillAppearWithLines:(NSInteger) lines textHeight: (CGFloat) height;
-(void)showKeyboardWithHeight:(CGFloat) height;
-(void)hideKeyboardWithHeight:(CGFloat) height;
@end
