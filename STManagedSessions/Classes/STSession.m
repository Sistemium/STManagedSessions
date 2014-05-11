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

+(STSession *)initWithUID:(NSString *)uid authDelegate:(id<STRequestAuthenticatable>)authDelegate trackers:(NSArray *)trackers startSettings:(NSDictionary *)startSettings documentPrefix:(NSString *)prefix {
    
    if (uid) {
        
        STSession *session = [[STSession alloc] init];
        session.status = @"starting";
        session.uid = uid;
        session.startSettings = startSettings;
        session.authDelegate = authDelegate;
        session.settingsController = [[STSettingsController alloc] init];
        session.trackers = [NSMutableDictionary dictionary];

        if ([trackers containsObject:@"location"]) {
            
            session.locationTracker = [[STLocationTracker alloc] init];
            [session.trackers setObject:session.locationTracker forKey:session.locationTracker.group];

        }
        
        if ([trackers containsObject:@"battery"]) {
            
            session.batteryTracker = [[STBatteryTracker alloc] init];
            [session.trackers setObject:session.batteryTracker forKey:session.batteryTracker.group];

        }
        
        [session addObservers];

        NSString *dataModelName = [startSettings valueForKey:@"dataModelName"];
        
        if (!dataModelName) {
            dataModelName = @"STDataModel";
        }

        session.document = [STDocument documentWithUID:session.uid dataModelName:dataModelName prefix:prefix];

        return session;
        
    } else {
        
        NSLog(@"no uid");
        return nil;
        
    }

}

- (void)stopSession {
    
    self.status = [self.status isEqualToString:@"removing"] ? self.status : @"finishing";

    if (self.document.documentState == UIDocumentStateNormal) {
        
        [self.document saveDocument:^(BOOL success) {
            
            if (success) {
                self.status = [self.status isEqualToString:@"removing"] ? self.status : @"stopped";
                [self.manager sessionStopped:self];
            } else {
                NSLog(@"Can not stop session with uid %@", self.uid);
            }
            
        }];
        
    }
    
}

- (void)dismissSession {
    
    if ([self.status isEqualToString:@"stopped"]) {
        
        [self removeObservers];
        
        if (self.document.documentState != UIDocumentStateClosed) {
            
            [self.document closeWithCompletionHandler:^(BOOL success) {
                
                if (success) {
                    
                    for (STTracker *tracker in self.trackers.allValues) {
                        [tracker prepareToDestroy];
                    }
                    [self.document.managedObjectContext reset];
                    [self.manager removeSessionForUID:self.uid];
                    
                }
                
            }];
            
        }
        
    }
    
}


- (void)addObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentReady:) name:@"documentReady" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(documentNotReady:) name:@"documentNotReady" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsLoadComplete) name:@"settingsLoadComplete" object:self.settingsController];

}

- (void)removeObservers {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"documentReady" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"documentNotReady" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"settingsLoadComplete" object:self.settingsController];

}

- (void)documentReady:(NSNotification *)notification {
    
    if ([[notification.userInfo valueForKey:@"uid"] isEqualToString:self.uid]) {
        
        self.logger = [[STLogger alloc] init];
        self.logger.session = self;

        [self.logger saveLogMessageWithText:[NSString stringWithFormat:@"document ready: %@", notification.object] type:nil];
        
        self.settingsController.startSettings = [self.startSettings mutableCopy];
        self.settingsController.session = self;

    }
    
}

- (void)documentNotReady:(NSNotification *)notification {
    
    if ([[notification.userInfo valueForKey:@"uid"] isEqualToString:self.uid]) {
        NSLog(@"document not ready");
    }
    
}

- (void)settingsLoadComplete {
    
//    NSLog(@"currentSettings %@", [self.settingsController currentSettings]);
    self.locationTracker.session = self;
    self.batteryTracker.session = self;
//    self.syncer.authDelegate = self.authDelegate;
//    self.syncer.session = self;
    self.status = @"running";
    
}


- (void)setAuthDelegate:(id<STRequestAuthenticatable>)authDelegate {
    
    if (_authDelegate != authDelegate) {
        _authDelegate = authDelegate;
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
