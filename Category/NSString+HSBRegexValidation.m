//
//  NSString+HSBRegexValidation.m
//  TPM
//
//  Created by HongSang bo on 2016. 1. 26..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "NSString+HSBRegexValidation.h"

@implementation NSString (HSBRegexValidation)
+(BOOL) validateEmail:(NSString *) email{
    NSString *emailRegex = @"[\\w\\d\\.\\_\\%\\+\\-]+@[\\w\\d\\.\\-]+(\\.[\\w\\d]{2,4}){1,2}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [pred evaluateWithObject:email];
}
@end
