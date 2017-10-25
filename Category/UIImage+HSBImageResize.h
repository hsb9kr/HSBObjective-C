//
//  UIImage+HSBImageResize.h
//  TPM
//
//  Created by HongSang bo on 2016. 1. 28..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HSBImageResize)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size;
@end
