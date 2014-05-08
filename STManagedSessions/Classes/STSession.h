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
#import "STSettingsController.h"
#import "STLocationTracker.h"
#import "STBatteryTracker.h"

@interface STSession : NSObject <STSession>

@property (nonatomic, strong) id <STRequestAuthenticatable> authDelegate;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) STDocument *document;
@property (nonatomic, strong) STLogger *logger;
@property (nonatomic, strong) id <STSessionManager> manager;
@property (nonatomic, strong) STSettingsController *settingsController;
@property (nonatomic, strong) STLocationTracker *locationTracker;
@property (nonatomic, strong) STBatteryTracker *batteryTracker;
@property (nonatomic, strong) NSMutableDictionary *trackers;


+ (STSession *)initWithUID:(NSString *)uid
              authDelegate:(id <STRequestAuthenticatable>)authDelegate
               trackers:(NSArray *)trackers
                  settings:(NSDictionary *)settings
            documentPrefix:(NSString *)prefix;

- (void)stopSession;

- (void)dismissSession;


@end
