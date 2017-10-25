//
//  CoreData.m
//  SecretCard
//
//  Created by HongSang bo on 2015. 2. 23..
//  Copyright (c) 2015년 HongSang bo. All rights reserved.
//

#import "HSBDataManage.h"

@implementation HSBDataManage
@synthesize coreDataHelper, context;
-(instancetype)init
{
    self = [super init];
    coreDataHelper = [HSBCoreDataHelper sharedInstance];
    context = [coreDataHelper managedObjectContext];
    return self;
}

@end
