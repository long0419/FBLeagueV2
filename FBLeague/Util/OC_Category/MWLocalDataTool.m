//
//  NSLocalDataTool.m
//  CarManager
//
//  Created by long-laptop on 16/1/1.
//  Copyright © 2016年 droidgle. All rights reserved.
//

#import "MWLocalDataTool.h"

static MWLocalDataTool *_instance = nil;
@implementation MWLocalDataTool

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

-(void) saveNSUserDefaultsWithKey :(NSString *)key AndObject : (NSData *) obj {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:key];
    [userDefaults synchronize];

}

-(id) readNSUserDefaultsWithKey : (NSString *) key {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    NSLog(@"userDefault %@" , [userDefaultes objectForKey:key]);
    return  [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaultes objectForKey:key]];
}

-(id) readNSUserDefaultsDicWithKey : (NSString *) key {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    return [userDefaultes objectForKey:key];
}


@end
