//
//  HSBJson.m
//  SocketDemo
//
//  Created by HongSang bo on 2016. 3. 22..
//  Copyright © 2016년 HongSang bo. All rights reserved.
//

#import "HSBJson.h"

@implementation HSBJson
+(NSString *) getJsonStringWithObject:(id)object{
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!json && error){
        NSLog(@"Json string Error : %@", error);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

+(NSData *) getJsonDataWithObject:(id)object{
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!json && error){
        NSLog(@"Json Data Error : %@", error);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    NSData *jsonData = [[NSData alloc] initWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return jsonData;
}

+(NSDictionary *) getJsonDictionaryWithString:(NSString *)jsonString{
    NSError *error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&error];
    
    if (!jsonDictionary && error){
        NSLog(@"Json String To Dictionary Error : %@", error);
        return nil;
    }
    
    return jsonDictionary;
}

+(NSDictionary *) getJsonDictionaryWithData:(NSData *)jsonData{
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&error];
    
    if (!jsonData && error){
        NSLog(@"Json Data To Dictionary Error : %@", error);
        return nil;
    }
    
    return jsonDictionary;
}

+(NSArray *) getJsonArrayWithString:(NSString *)jsonString{
    NSError *error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&error];
    
    if (!jsonArray && error){
        NSLog(@"Json String To Dictionary Error : %@", error);
        return nil;
    }
    
    return jsonArray;
}

+(NSArray *) getJsonArrayWithData:(NSData *)jsonData{
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&error];
    
    if (!jsonData && error){
        NSLog(@"Json Data To Dictionary Error : %@", error);
        return nil;
    }
    
    return jsonArray;
}

@end
