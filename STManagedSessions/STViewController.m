//
//  STViewController.m
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STViewController.h"
#import "STSessionManager.h"
#import <CoreLocation/CoreLocation.h>
#import "STSettingsTVC.h"
#import <KiteJSONValidator/KiteJSONValidator.h>

#define UID @"1"

@interface STViewController ()

@property (nonatomic, strong) STSessionManager *sessionManager;

@end

@implementation STViewController

- (STSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [STSessionManager sharedManager];
    }
    
    return _sessionManager;
    
}

- (void)sessionStatusChanged:(NSNotification *)notification {
    
    if ([notification.object conformsToProtocol:@protocol(STSession)]) {
        
        id <STSession> session = notification.object;
        
        if ([session.uid isEqualToString:UID]) {
            
            STSettingsTVC *settingsTVC = [[STSettingsTVC alloc] init];
            settingsTVC.session = session;
            [self.navigationController pushViewController:settingsTVC animated:YES];
            
        }
        
    }
    
}

- (void)JSONValidate {
    
    KiteJSONValidator *JSONValidator = [[KiteJSONValidator alloc] init];
    
    NSString *schemaPath = [[NSBundle mainBundle] pathForResource:@"settings_schema" ofType:@"json"];
    NSData *schemaData = [NSData dataWithContentsOfFile:schemaPath];

    NSString *settingsPath = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"json"];
    NSData *settingsData = [NSData dataWithContentsOfFile:settingsPath];

    if ([JSONValidator validateJSONData:settingsData withSchemaData:schemaData]) {
        
        NSError *error;
        NSDictionary *settingsJSON = [NSJSONSerialization JSONObjectWithData:settingsData options:NSJSONReadingMutableContainers error:&error];
        NSArray *defaultSettings = [settingsJSON objectForKey:@"defaultSettings"];

        for (NSDictionary *group in defaultSettings) {
            
            NSString *groupName = [group valueForKey:@"group"];
            NSLog(@"groupName %@", groupName);
            
            NSArray *data = [group valueForKey:@"data"];
            
            for (NSDictionary *settingItem in data) {
                
                NSString *itemName = [settingItem valueForKey:@"name"];
                id itemValue = [settingItem valueForKey:@"value"];
                NSString *itemConrtolType = [settingItem valueForKey:@"control"];
                NSNumber *itemMinValue = [settingItem valueForKey:@"min"];
                NSNumber *itemMaxValue = [settingItem valueForKey:@"max"];
                NSNumber *itemStepValue = [settingItem valueForKey:@"step"];
                
                NSLog(@"%@", itemName);
                
            }
            
        }

        
    } else {
        NSLog(@"JSON not valid");
    }
    
}

- (void)customInit {
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStatusChanged:) name:@"sessionStatusChanged" object:nil];
//    
//    NSArray *trackers = [NSArray arrayWithObjects:@"battery", @"location", nil];
//    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
//                                        [NSString stringWithFormat:@"%d", YES], @"batteryTrackerAutoStart",
//                                        @"8.0", @"batteryTrackerStartTime",
//                                        @"20.0", @"batteryTrackerFinishTime",
//                                        [NSString stringWithFormat:@"%d", YES], @"locationTrackerAutoStart",
//                                        @"8.0", @"locationTrackerStartTime",
//                                        @"20.0", @"locationTrackerFinishTime",
//                                        [NSString stringWithFormat:@"%f", kCLDistanceFilterNone], @"distanceFilter",
//                                        @"0", @"requiredAccuracy",
//                                     nil];

    [self JSONValidate];
    
//    [self.sessionManager startSessionForUID:UID authDelegate:nil trackers:trackers settings:settings settingsFileName:@"settings" documentPrefix:@"test"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customInit];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
