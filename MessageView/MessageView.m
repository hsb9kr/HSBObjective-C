//
//  MessageViewArea.m
//  OpenCV-test
//
//  Created by HongSang bo on 2015. 12. 11..
//  Copyright © 2015년 HongSang bo. All rights reserved.
//

#import "MessageView.h"

@interface MessageView()

@end

@implementation MessageView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubView];
        return self;
    }
    return nil;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubView];
        return self;
    }
    
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
    CGRect initFrame = frame;
    initFrame.size.height = height;
    initFrame.origin.y = frame.size.height - initFrame.size.height;
    _y = initFrame.origin.y;
    self = [super initWithFrame:initFrame];
    if (self) {
        [self setBackgroundColor:[UIColor yellowColor]];
        [self initSubViewWithFrame];
        return self;
    }
    return nil;
}

-(void) initSubView{
    _msgTextView = [[UITextView alloc] init];
    _msgSendBtn = [[UIButton alloc] init];
    [self addSubview:_msgTextView];
    [self addSubview:_msgSendBtn];
    _lines = 1;
}

-(void) initSubViewWithFrame{
    CGFloat sendBtnX = self.bounds.size.width - sendBtnWidth;
    CGFloat sendBtnY = self.bounds.size.height - sendBtnHeight;
    CGFloat textViewX = 0.f;
    CGFloat textViewY = self.bounds.size.height - sendBtnHeight;
    CGFloat textViewWidth = self.bounds.size.width - sendBtnWidth;
    
    CGRect sendBtnFrame = CGRectMake(sendBtnX, sendBtnY - 5.f, sendBtnWidth, sendBtnHeight);
    CGRect textViewFrame = CGRectMake(textViewX + 2.f, textViewY - 5.f, textViewWidth, textViewHeight);
    
    _msgSendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_msgSendBtn setFrame:sendBtnFrame];
    
    _msgTextView = [[UITextView alloc] initWithFrame:textViewFrame];
    _msgTextView.layer.borderWidth = 1.0f;
    _msgTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    _msgTextView.layer.cornerRadius = 8.f;
    
    [_msgSendBtn setTitle:@"SEND" forState:UIControlStateNormal];
    [_msgSendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_msgSendBtn setTitleEdgeInsets:UIEdgeInsetsMake(1.f, 1.f, 1.f, 1.f)];
    _msgSendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_msgTextView setFont:[UIFont systemFontOfSize:12]];
    
    [self addSubview:_msgSendBtn];
    [self addSubview:_msgTextView];

    _lines = 1;
}

-(void) viewWillAppearLine{
    CGRect msgViewFrame = self.frame;
    CGRect textViewFrame = _msgTextView.frame;
    CGRect btnFrame = _msgSendBtn.frame;
    NSInteger lines = (_lines - 1);
    
    msgViewFrame.origin.y = _y - _msgTextView.font.lineHeight * lines;
    msgViewFrame.size.height = height + _msgTextView.font.lineHeight * lines;
    textViewFrame.size.height = textViewHeight + _msgTextView.font.lineHeight * lines;
    btnFrame.size.height = sendBtnHeight + _msgTextView.font.lineHeight * lines;
    
    _msgTextView.frame = textViewFrame;
    self.frame = msgViewFrame;
    _msgSendBtn.frame = btnFrame;
}

-(void)showKeyboardWithHeight:(CGFloat) height{
    self.transform = CGAffineTransformMakeTranslation(0.0, -height);
    _y -= height;
}

-(void)hideKeyboardWithHeight:(CGFloat) height{
    self.transform = CGAffineTransformIdentity;
    _y += height;
}

@end
