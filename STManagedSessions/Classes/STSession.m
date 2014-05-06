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
        session.status = @"starting";
        session.uid = uid;
        session.startSettings = settings;
        session.authDelegate = authDelegate;

        [session addObservers];
        
        NSString *dataModelName = [settings valueForKey:@"dataModelName"];
        
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
    
    self.status = @"finishing";

    if (self.document.documentState == UIDocumentStateNormal) {
        
        [self.document saveDocument:^(BOOL success) {
            
            if (success) {
                self.status = @"stopped";
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

}

- (void)removeObservers {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"documentReady" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"documentNotReady" object:nil];

}

- (void)documentReady:(NSNotification *)notification {
    
    if ([[notification.userInfo valueForKey:@"uid"] isEqualToString:self.uid]) {
        
        self.logger = [[STLogger alloc] init];
        self.logger.session = self;

        [self.logger saveLogMessageWithText:[NSString stringWithFormat:@"document ready: %@", notification.object] type:nil];
        
        self.status = @"running";

    }
    
}

- (void)documentNotReady:(NSNotification *)notification {
    
    if ([[notification.userInfo valueForKey:@"uid"] isEqualToString:self.uid]) {
        NSLog(@"document not ready");
    }
    
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
