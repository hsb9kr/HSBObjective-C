//
//  MSGLabel.m
//  OpenCV-test
//
//  Created by HongSang bo on 2015. 12. 16..
//  Copyright © 2015년 HongSang bo. All rights reserved.
//

#import "MSGLabel.h"

@implementation MSGLabel

-(instancetype)init{
    self = [super init];
    if (!self)
        return nil;

    self.backgroundColor = [UIColor clearColor];
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.font = [UIFont systemFontOfSize:14.0];
    
    return self;
}
- (void)drawRect:(CGRect)rect {
    UIEdgeInsets insets = {10, 10, 10, 10};

    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end
