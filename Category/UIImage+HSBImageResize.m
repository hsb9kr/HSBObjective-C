//
//  UIImage+HSBImageResize.m
//  TPM
//
//  Created by HongSang bo on 2016. 1. 28..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "UIImage+HSBImageResize.h"

@implementation UIImage (HSBImageResize)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
