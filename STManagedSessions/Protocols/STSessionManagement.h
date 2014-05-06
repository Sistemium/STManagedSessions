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

//@protocol STSessionManager <NSObject>
//
//- (void)startSessionForUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate controllers:(NSDictionary *)controllers settings:(NSDictionary *)settings documentPrefix:(NSString *)prefix;
//- (void)stopSessionForUID:(NSString *)uid;
//- (void)sessionCompletionFinished:(id)session;
//- (void)cleanCompletedSessions;
//
//@end
//
//@protocol STSettingsController <NSObject>
//
//- (NSMutableDictionary *)currentSettingsForGroup:(NSString *)group;
//
//@end

@protocol STSession <NSObject>

+ (id <STSession>)initWithUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate controllers:(NSArray *)controllers settings:(NSDictionary *)settings documentPrefix:(NSString *)prefix;

//- (void)completeSession;
//- (void)dismissSession;
//- (void)settingsLoadComplete;

@property (strong, nonatomic) UIManagedDocument *document;
//@property (nonatomic, strong) id <STSettingsController> settingsController;
//@property (strong, nonatomic) NSString *status;

@end