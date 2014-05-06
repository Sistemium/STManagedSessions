//
//  STSession.m
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STSession.h"

@interface STSession()

@property (nonatomic, strong) NSDictionary *startSettings;

@end

@implementation STSession

+(STSession *)initWithUID:(NSString *)uid authDelegate:(id<STRequestAuthenticatable>)authDelegate controllers:(NSArray *)controllers settings:(NSDictionary *)settings documentPrefix:(NSString *)prefix {
    
    if (uid) {
        
        STSession *session = [[STSession alloc] init];
        session.status = @"initialization";
        session.uid = uid;
        session.startSettings = settings;
        session.authDelegate = authDelegate;

        [[NSNotificationCenter defaultCenter] addObserver:session selector:@selector(documentReady:) name:@"documentReady" object:nil];
        
        NSString *dataModelName = [settings valueForKey:@"dataModelName"];
        
        if (!dataModelName) {
            dataModelName = @"STDataModel";
        }

        session.document = [STDocument documentWithUID:session.uid dataModelName:dataModelName prefix:prefix];
//
//        id locationTracker = [controllers objectForKey:@"locationTracker"];
//        if ([locationTracker isKindOfClass:[STTracker class]]) {
//            session.locationTracker = locationTracker;
//        } else {
//            session.locationTracker = [[STLocationTracker alloc] init];
//        }
//        id batteryTracker = [controllers objectForKey:@"batteryTracker"];
//        if ([batteryTracker isKindOfClass:[STTracker class]]) {
//            session.batteryTracker = batteryTracker;
//        } else {
//            session.batteryTracker = [[STBatteryTracker alloc] init];
//        }
//        
//        id settingsController = [controllers objectForKey:@"settingsController"];
//        if ([settingsController isKindOfClass:[STSettingsController class]]) {
//            session.settingsController = settingsController;
//        } else {
//            session.settingsController = [[STSettingsController alloc] init];
//        }
//        
//        id syncer = [controllers objectForKey:@"syncer"];
//        if ([syncer isKindOfClass:[STSyncer class]]) {
//            session.syncer = syncer;
//        } else {
//            session.syncer = [[STSyncer alloc] init];
//        }
//        
//
//
        return session;
        
    } else {
        
        NSLog(@"no uid");
        return nil;
        
    }

}

- (void)documentReady:(NSNotification *)notification {
    
    if ([[notification.userInfo valueForKey:@"uid"] isEqualToString:self.uid]) {
        
        self.logger = [[STLogger alloc] init];
        self.logger.session = self;

        [self.logger saveLogMessageWithText:[NSString stringWithFormat:@"document ready: %@", notification.object] type:nil];
        
//        self.settingsController.startSettings = [self.startSettings mutableCopy];
        //        self.settingsController = [STSettingsController initWithSettings:self.startSettings];
//        self.settingsController.session = self;

    }
    
}

- (void)setAuthDelegate:(id<STRequestAuthenticatable>)authDelegate {
    
    if (_authDelegate != authDelegate) {
        _authDelegate = authDelegate;
//        self.syncer.authDelegate = _authDelegate;
    }
    
}

- (void)setStatus:(NSString *)status {
    
    if (_status != status) {
        
        _status = status;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sessionStatusChanged" object:self];
        [self.logger saveLogMessageWithText:[NSString stringWithFormat:@"Session status changed to %@", self.status] type:nil];
        
    }
    
}



@end
