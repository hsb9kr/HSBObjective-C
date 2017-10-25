//
//  MessageTableView.m
//  OpenCV-test
//
//  Created by HongSang bo on 2015. 12. 11..
//  Copyright © 2015년 HongSang bo. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageTableViewCell.h"

@implementation MessageTableView

-(instancetype) initWithFrame: (CGRect) frame MessageViewWithFrame : (CGRect) mvFrame{
    CGRect initFrame = frame;
    initFrame.size.height -= mvFrame.size.height;
    _height = initFrame.size.height;
    self = [super initWithFrame:initFrame];
    if (self) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.allowsSelection = NO;
        [self registerClass:[MessageTableViewCell class] forCellReuseIdentifier:CellIdentifier];
        return self;
    }
    
    return nil;
}

-(void)viewWillAppearWithLines:(NSInteger) lines textHeight: (CGFloat) height{
    CGRect msgTableViewFrame = self.frame;
    msgTableViewFrame.size.height = _height - height * (lines - 1);
    self.frame = msgTableViewFrame;
}

-(void)showKeyboardWithHeight:(CGFloat) height{
    CGRect frame = self.frame;
    frame.size.height -= height;
    self.frame = frame;
    _height -= height;
}

-(void)hideKeyboardWithHeight:(CGFloat) height{
    CGRect frame = self.frame;
    frame.size.height += height;
    self.frame = frame;
    _height += height;
}

@end
