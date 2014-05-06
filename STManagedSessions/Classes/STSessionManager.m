//
//  STSessionManager.m
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STSessionManager.h"
#import "STSession.h"

@implementation STSessionManager

+ (STSessionManager *)sharedManager {
    static dispatch_once_t pred = 0;
    __strong static id _sharedManager = nil;
    dispatch_once(&pred, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (NSMutableDictionary *)sessions {
    if (!_sessions) {
        _sessions = [NSMutableDictionary dictionary];
    }
    return _sessions;
}

- (id <STSession>)startSessionForUID:(NSString *)uid authDelegate:(id<STRequestAuthenticatable>)authDelegate controllers:(NSArray *)controllers settings:(NSDictionary *)settings documentPrefix:(NSString *)prefix {
    
    if (uid) {
        
        STSession *session = [self.sessions objectForKey:uid];
        
        if (!session) {
            
            session = [STSession initWithUID:uid authDelegate:authDelegate controllers:controllers settings:settings documentPrefix:prefix];
            session.manager = self;

            [self.sessions setValue:session forKey:uid];
            
        } else {
            
            session.authDelegate = authDelegate;
            session.status = @"running";
            
        }
        
        return session;
        
    } else {
        
        NSLog(@"no uid");
        return nil;
        
    }

}

- (void)stopSessionForUID:(NSString *)uid {
    
    STSession *session = [self.sessions objectForKey:uid];
    
    if ([session.status isEqualToString:@"running"]) {
        [session stopSession];
    }
    
}

- (void)sessionStopped:(id <STSession>)session {
    
}

- (void)cleanStoppedSessions {

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.status == %@", @"stopped"];
    NSArray *completedSessions = [[self.sessions allValues] filteredArrayUsingPredicate:predicate];
    
    for (STSession *session in completedSessions) {
        [session dismissSession];
    }

}

- (void)removeSessionForUID:(NSString *)uid {

    if ([[(STSession *)[self.sessions objectForKey:uid] status] isEqualToString:@"stopped"]) {
        [self.sessions removeObjectForKey:uid];
    }

}


@end
