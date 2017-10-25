//
//  InfoCoreData.m
//  TPM
//
//  Created by HongSang bo on 2016. 3. 10..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "InfoCoreData.h"
#import "Info.h"

@interface InfoCoreData()
@property (strong, nonatomic) NSString *INFOENTITY;
@end

@implementation InfoCoreData

-(instancetype)init{
    self = [super init];
    if (self) {
        _INFOENTITY = @"Info";

    }
    return self;
}

-(BOOL) insertInfoAutoSignIn: (BOOL) isAutoSignIn userkey: (NSString *)userkey signInToken: (NSString *) signInToken email: (NSString *)email{
    Info *info = [NSEntityDescription insertNewObjectForEntityForName:_INFOENTITY inManagedObjectContext: context];
    info.userkey = userkey;
    info.autoSignIn = [NSNumber numberWithBool:isAutoSignIn];
    info.signInToken = signInToken;
    info.email = email;
    return [coreDataHelper saveContext];
}

-(BOOL) updateInfoAutoSignIn: (BOOL) isAutoSignIn userkey: (NSString *)userkey signInToken: (NSString *) signInToken email: (NSString *)email{
    Info *info = [self getInfo];
    if (!info) {
        info = [NSEntityDescription insertNewObjectForEntityForName:_INFOENTITY inManagedObjectContext: context];
    }
    info.userkey = userkey;
    info.autoSignIn = [NSNumber numberWithBool:isAutoSignIn];
    info.signInToken = signInToken;
    info.email = email;
    return [coreDataHelper saveContext];
}

-(Info *) getInfo{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:_INFOENTITY];
    NSArray *results = nil;
    NSError *error = nil;
    Info *info = nil;
    request.returnsObjectsAsFaults = NO;
    
    @try {
        results = [context executeFetchRequest:request error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"%@ error : %@", _INFOENTITY, error);
    }

    if (results.count > 0) {
        info = results[0];
    }
    return info;
}

-(BOOL) deleteInfo{
    Info *info = [self getInfo];
    [context deleteObject:info];
    return [coreDataHelper saveContext];
}
@end
