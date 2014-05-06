//
//  STSessionManager.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STSessionManagement.h"

@interface STSessionManager : NSObject <STSessionManager>

@property (nonatomic, strong) NSMutableDictionary *sessions;
@property (nonatomic, strong) id <STSession> currentSession;

+ (STSessionManager *)sharedManager;

- (id <STSession>)startSessionForUID:(NSString *)uid
              authDelegate:(id <STRequestAuthenticatable>)authDelegate
               controllers:(NSArray *)controllers
                  settings:(NSDictionary *)settings
            documentPrefix:(NSString *)prefix;

- (void)stopSessionForUID:(NSString *)uid;

- (void)sessionStopped:(id <STSession>)session;

- (void)cleanStoppedSessions;

- (void)removeSessionForUID:(NSString *)uid;


@end
