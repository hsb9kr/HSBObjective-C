//
//  SecretManageDocument.h
//  SecretCard
//
//  Created by HongSang bo on 2015. 6. 24..
//  Copyright (c) 2015년 HongSang bo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HSBCoreDataHelper : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(HSBCoreDataHelper *) sharedInstance;
-(BOOL)saveContext;

@end
