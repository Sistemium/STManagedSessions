//
//  STGTSessionManagement.h
//  geotracker
//
//  Created by Maxim Grigoriev on 3/24/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "STManagedDocument.h"
#import "STRequestAuthenticatable.h"

@protocol STSession <NSObject>

+ (id <STSession>)initWithUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate controllers:(NSArray *)controllers settings:(NSDictionary *)settings documentPrefix:(NSString *)prefix;

//- (void)completeSession;
//- (void)dismissSession;
//- (void)settingsLoadComplete;

@property (strong, nonatomic) UIManagedDocument *document;
@property (nonatomic, strong) NSString *uid;
@property (strong, nonatomic) NSString *status;

//@property (nonatomic, strong) id <STSettingsController> settingsController;

@end

@protocol STSessionManager <NSObject>

- (id <STSession>)startSessionForUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate controllers:(NSArray *)controllers settings:(NSDictionary *)settings documentPrefix:(NSString *)prefix;
- (void)stopSessionForUID:(NSString *)uid;
- (void)sessionStopped:(id)session;
- (void)cleanStoppedSessions;
- (void)removeSessionForUID:(NSString *)uid;

@end
//
//@protocol STSettingsController <NSObject>
//
//- (NSMutableDictionary *)currentSettingsForGroup:(NSString *)group;
//
//@end
