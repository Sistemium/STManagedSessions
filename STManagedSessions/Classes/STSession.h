//
//  STSession.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STRequestAuthenticatable.h"

@interface STSession : NSObject

@property (nonatomic, strong) id <STRequestAuthenticatable> authDelegate;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *status;


+ (STSession *)initWithUID:(NSString *)uid
              authDelegate:(id <STRequestAuthenticatable>)authDelegate
               controllers:(NSArray *)controllers
                  settings:(NSDictionary *)settings
            documentPrefix:(NSString *)prefix;

//- (void)completeSession;
//
//- (void)dismissSession;
//
//- (void)settingsLoadComplete;


@end
