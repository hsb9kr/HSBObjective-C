//
//  SecretManageDocument.m
//  SecretCard
//
//  Created by HongSang bo on 2015. 6. 24..
//  Copyright (c) 2015년 HongSang bo. All rights reserved.
//

#import "HSBCoreDataHelper.h"

@implementation HSBCoreDataHelper
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+(HSBCoreDataHelper *) sharedInstance
{
    static HSBCoreDataHelper *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

-(BOOL)saveContext
{
    NSError *error;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil)
    {
        // 변경 사항이 있지만 저장에 실패한 경우
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // 실제 구현할때 이 부분은 수정해야한다. abort 메소드는 crash를 유발하므로 사용하면 안된다!
            NSLog(@"Unresolved error : %@, %@", error, [error userInfo]);
//            abort();
        }else{
            return YES;
        }
    }
    
    return NO;
}

-(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSURL *)applicationGroupDocumentDirectory
{
    return [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.hsb9kr.TPMCoreData"];
}


#pragma mark -
#pragma mark MyManagedDocument [@property]
-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)    return _managedObjectModel;
    
    // 컴파일된 Data Object Model(Xcode상의 .xcdatamodeld)에 접근하여 객체로 생성.
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TPM" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)  return _managedObjectContext;
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        
        // Persistent Store Coordinator 연결.
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)    return _persistentStoreCoordinator;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSError *error = nil;
    NSURL *groupURL = [[self applicationGroupDocumentDirectory] URLByAppendingPathComponent:@"TPM.sqlite"];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TPM.sqlite"];
    NSURL *targetURL = nil;
    
    bool needMigrate = false;
    bool needDeleteOld  = false;
    
    if ([filemgr fileExistsAtPath:[storeURL path]]) {
        NSLog(@"old single app db exist.");
        targetURL = storeURL;
        needMigrate = true;
    }
    
    if ([filemgr fileExistsAtPath:[groupURL path]]) {
        NSLog(@"group db exist");
        needMigrate = false;
        targetURL = groupURL;
        
        if ([filemgr fileExistsAtPath:[storeURL path]]) {
            needDeleteOld = true;
        }
    }
    
    if (targetURL == nil)
        targetURL = groupURL;

    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES),
                              NSInferMappingModelAutomaticallyOption: @(YES)};
    
//    // Persistent Store Coordinator 설정. 저장소 타입을 SQLite로 한다.
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
//                                                   configuration:nil
//                                                             URL:targetURL
//                                                         options:options
//                                                           error:&error])
//        
//    {
//        // 여기로 마찬가지로 실제 앱 개발시에는 반드시 수정해야한다.
//        
//    }
    NSPersistentStore *store;
    store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:targetURL options:options error:&error];
    if (!store) {
        NSLog(@"Unresolved error : %@, %@", error, [error userInfo]);
        abort();
    }

    
    if (needMigrate) {
        NSError *error = nil;
        NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [context setPersistentStoreCoordinator:_persistentStoreCoordinator];
        [_persistentStoreCoordinator migratePersistentStore:store toURL:groupURL options:options withType:NSSQLiteStoreType error:&error];
        if (error != nil) {
            NSLog(@"Error when migration to groupd url %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    if (needDeleteOld) {
        [filemgr removeItemAtURL:storeURL error:&error];
    }
    
    return _persistentStoreCoordinator;
}

@end
