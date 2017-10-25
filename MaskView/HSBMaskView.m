//
//  HSBMaskView.m
//  TPM
//
//  Created by HongSang bo on 2016. 1. 26..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBMaskView.h"

@implementation HSBMaskView

+(HSBMaskView *) sharedMaskView{
    static HSBMaskView *sharedMaskView = nil;
    static dispatch_once_t onceMaskToken;
    dispatch_once(&onceMaskToken, ^{
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        sharedMaskView = [[self alloc] initWithFrame:screenBounds];
        [sharedMaskView setBackgroundColor:[UIColor blackColor]];
        sharedMaskView.alpha = 0.2f;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20.f, 20.f)];
        [sharedMaskView addSubview:indicator];
        indicator.center = CGPointMake(screenBounds.size.width/2, screenBounds.size.height/2);
        [indicator setHidden:NO];
        [indicator startAnimating];
    });
    
    return sharedMaskView;
}

-(instancetype)init{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (self = [super initWithFrame:screenBounds]) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.alpha = 0.2f;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20.f, 20.f)];
        [self addSubview:indicator];
        indicator.center = CGPointMake(screenBounds.size.width/2, screenBounds.size.height/2);
        [indicator setHidden:NO];
        [indicator startAnimating];
        return self;
    }
    return nil;
}
@end
