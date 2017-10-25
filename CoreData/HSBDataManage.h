//
//  CoreData.h
//  SecretCard
//
//  Created by HongSang bo on 2015. 2. 23..
//  Copyright (c) 2015년 HongSang bo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSBCoreDataHelper.h"
@class HSBCoreDataHelper;

@interface HSBDataManage : NSObject{
    HSBCoreDataHelper *coreDataHelper;
    NSManagedObjectContext *context;
}

@property (strong, nonatomic) HSBCoreDataHelper *coreDataHelper;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end
