//
//  STSession.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STRequestAuthenticatable.h"
#import "STSessionManagement.h"
#import "STDocument.h"
#import "STLogger.h"

@interface STSession : NSObject <STSession>

@property (nonatomic, strong) id <STRequestAuthenticatable> authDelegate;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) STDocument *document;
@property (nonatomic, strong) STLogger *logger;


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
