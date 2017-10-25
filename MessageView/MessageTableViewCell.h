//
//  MessageTableViewCell.h
//  OpenCV-test
//
//  Created by HongSang bo on 2015. 12. 11..
//  Copyright © 2015년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSGContent;
@class MSGLabel;

@interface MessageTableViewCell : UITableViewCell
@property (strong, nonatomic) MSGLabel *msgLabel;
@property (strong, nonatomic) UIView *msgView;
@property (strong, nonatomic) UIImageView *imgView;
-(void) setMineContent: (MSGContent *)content;
-(void) setOtherContent: (MSGContent *)content;
@end
