//
//  UIImage+Blur.h
//  BlueStamp
//
//  Created by HongSang bo on 2016. 3. 30..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)
- (UIImage *)blurWithCoreImageByRadius : (NSNumber *)number targetView: (UIView *)view;
@end
