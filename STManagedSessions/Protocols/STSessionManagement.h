//
//  STGTSessionManagement.h
//  geotracker
//
//  Created by Maxim Grigoriev on 3/24/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STRequestAuthenticatable.h"

@protocol STLogger <NSObject, UITableViewDataSource, UITableViewDelegate>

- (void)saveLogMessageWithText:(NSString *)text type:(NSString *)type;

@property (nonatomic, weak) UITableView *tableView;

@end


@protocol STSettingsController <NSObject>

- (NSArray *)currentSettings;
- (NSMutableDictionary *)currentSettingsForGroup:(NSString *)group;
- (NSString *)setNewSettings:(NSDictionary *)newSettings forGroup:(NSString *)group;

@end



@protocol STSession <NSObject>

+ (id <STSession>)initWithUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate trackers:(NSArray *)trackers startSettings:(NSDictionary *)startSettings documentPrefix:(NSString *)prefix;

@property (nonatomic, strong) UIManagedDocument *document;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) id <STSettingsController> settingsController;
@property (nonatomic, strong) NSDictionary *settingsControls;
@property (nonatomic, strong) NSDictionary *defaultSettings;
@property (nonatomic, strong) id <STLogger> logger;

@end



@protocol STSessionManager <NSObject>

- (id <STSession>)startSessionForUID:(NSString *)uid authDelegate:(id <STRequestAuthenticatable>)authDelegate trackers:(NSArray *)trackers startSettings:(NSDictionary *)startSettings defaultSettingsFileName:(NSString *)defualtSettingsFileName documentPrefix:(NSString *)prefix;
- (void)stopSessionForUID:(NSString *)uid;
- (void)sessionStopped:(id)session;
- (void)cleanStoppedSessions;
- (void)removeSessionForUID:(NSString *)uid;

@end
