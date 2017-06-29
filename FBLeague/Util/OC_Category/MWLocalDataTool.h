//
//  NSLocalDataTool.h
//  CarManager
//
//  Created by long-laptop on 16/1/1.
//  Copyright © 2016年 droidgle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWLocalDataTool : NSObject

+(instancetype) shareInstance ;

-(void) saveNSUserDefaultsWithKey :(NSString *)key AndObject : (NSData *) obj ;
-(id) readNSUserDefaultsWithKey : (NSString *) key ;
-(id) readNSUserDefaultsDicWithKey :(NSString *)key ;
@end
