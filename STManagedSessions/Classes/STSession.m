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
        session.uid = uid;
        session.startSettings = settings;
        session.authDelegate = authDelegate;
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
//        [[NSNotificationCenter defaultCenter] addObserver:session selector:@selector(documentReady:) name:@"documentReady" object:nil];
//        
//        NSString *dataModelName = [settings valueForKey:@"dataModelName"];
//        
//        if (!dataModelName) {
//            dataModelName = @"STDataModel";
//        }
//        
//        session.document = [STManagedDocument documentWithUID:session.uid dataModelName:dataModelName prefix:prefix];
//        
        return session;
        
    } else {
        NSLog(@"no uid");
        return nil;
    }

}


@end
