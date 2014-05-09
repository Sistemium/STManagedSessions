//
//  STSettingsData.m
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 09/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STSettingsData.h"
#import <CoreLocation/CoreLocation.h>

@implementation STSettingsData


+ (NSDictionary *)defaultSettings {
    NSMutableDictionary *defaultSettings = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *locationTrackerSettings = [NSMutableDictionary dictionary];
    [locationTrackerSettings setValue:[NSString stringWithFormat:@"%f", kCLLocationAccuracyBestForNavigation] forKey:@"desiredAccuracy"];
    [locationTrackerSettings setValue:@"10.0" forKey:@"requiredAccuracy"];
    [locationTrackerSettings setValue:[NSString stringWithFormat:@"%f", kCLDistanceFilterNone] forKey:@"distanceFilter"];
    [locationTrackerSettings setValue:@"0" forKey:@"timeFilter"];
    [locationTrackerSettings setValue:@"300.0" forKey:@"trackDetectionTime"];
    [locationTrackerSettings setValue:@"100.0" forKey:@"trackSeparationDistance"];
    [locationTrackerSettings setValue:[NSString stringWithFormat:@"%d", NO] forKey:@"locationTrackerAutoStart"];
    [locationTrackerSettings setValue:@"8.0" forKey:@"locationTrackerStartTime"];
    [locationTrackerSettings setValue:@"20.0" forKey:@"locationTrackerFinishTime"];
    [locationTrackerSettings setValue:@"0.1" forKey:@"deviceMotionUpdateInterval"];
    [locationTrackerSettings setValue:[NSString stringWithFormat:@"%d", NO] forKey:@"deviceMotionUpdate"];
    
    [defaultSettings setValue:locationTrackerSettings forKey:@"location"];
    
    
    NSMutableDictionary *batteryTrackerSettings = [NSMutableDictionary dictionary];
    [batteryTrackerSettings setValue:[NSString stringWithFormat:@"%d", NO] forKey:@"batteryTrackerAutoStart"];
    [batteryTrackerSettings setValue:@"8.0" forKey:@"batteryTrackerStartTime"];
    [batteryTrackerSettings setValue:@"20.0" forKey:@"batteryTrackerFinishTime"];
    
    [defaultSettings setValue:batteryTrackerSettings forKey:@"battery"];
    
    
    NSMutableDictionary *syncerSettings = [NSMutableDictionary dictionary];
    [syncerSettings setValue:@"20" forKey:@"fetchLimit"];
    [syncerSettings setValue:@"240.0" forKey:@"syncInterval"];
    [syncerSettings setValue:@"https://system.unact.ru/iproxy/rest" forKey:@"restServerURI"];
    [syncerSettings setValue:@"https://system.unact.ru/iproxy/news/megaport" forKey:@"recieveDataServerURI"];
    [syncerSettings setValue:@"https://system.unact.ru/iproxy/chest/test" forKey:@"sendDataServerURI"];
    [syncerSettings setValue:@"https://github.com/sys-team/ASA.chest" forKey:@"xmlNamespace"];
    
    [defaultSettings setValue:syncerSettings forKey:@"syncer"];
    
    
    NSMutableDictionary *generalSettings = [NSMutableDictionary dictionary];
    [generalSettings setValue:[NSString stringWithFormat:@"%d", YES] forKey:@"localAccessToSettings"];
    
    [defaultSettings setValue:generalSettings forKey:@"general"];
    
    
    return defaultSettings;
    
}

+ (NSDictionary *)controlsSettings {
    
    NSMutableDictionary *controlsSettings = [NSMutableDictionary dictionary];
    
    NSMutableArray *locationTrackerSettings = [NSMutableArray array];
    //                                      control, min, max, step, name
    [locationTrackerSettings addObject:@[@"slider", @"0", @"5", @"1", @"desiredAccuracy"]];
    [locationTrackerSettings addObject:@[@"slider", @"0", @"100", @"10", @"requiredAccuracy"]];
    [locationTrackerSettings addObject:@[@"slider", @"-1", @"200", @"10", @"distanceFilter"]];
    [locationTrackerSettings addObject:@[@"slider", @"1", @"60", @"5", @"timeFilter"]];
    [locationTrackerSettings addObject:@[@"slider", @"0", @"600", @"30", @"trackDetectionTime"]];
    [locationTrackerSettings addObject:@[@"slider", @"1", @"1000", @"100", @"trackSeparationDistance"]];
    [locationTrackerSettings addObject:@[@"slider", @"0", @"120", @"20", @"maxSpeedThreshold"]];
    [locationTrackerSettings addObject:@[@"switch", @"", @"", @"", @"getLocationsWithNegativeSpeed"]];
    [locationTrackerSettings addObject:@[@"switch", @"", @"", @"", @"locationTrackerAutoStart"]];
    [locationTrackerSettings addObject:@[@"slider", @"0", @"24", @"0.5", @"locationTrackerStartTime"]];
    [locationTrackerSettings addObject:@[@"slider", @"0", @"24", @"0.5", @"locationTrackerFinishTime"]];
    
    [controlsSettings setValue:locationTrackerSettings forKey:@"location"];
    
    
//    NSMutableArray *mapSettings = [NSMutableArray array];
//    [mapSettings addObject:@[@"switch", @"", @"", @"", @"showLocationInsteadOfMap"]];
//    [mapSettings addObject:@[@"segmentedControl", @"0", @"2", @"1", @"mapHeading"]];
//    [mapSettings addObject:@[@"segmentedControl", @"0", @"2", @"1", @"mapType"]];
//    [mapSettings addObject:@[@"segmentedControl", @"0", @"1", @"1", @"mapProvider"]];
//    [mapSettings addObject:@[@"slider", @"1", @"10", @"0.5", @"trackScale"]];
//    
//    [controlsSettings setValue:mapSettings forKey:@"map"];
    
    
    NSMutableArray *syncerSettings = [NSMutableArray array];
    [syncerSettings addObject:@[@"slider", @"10", @"200", @"10", @"fetchLimit"]];
    [syncerSettings addObject:@[@"slider", @"10", @"3600", @"60", @"syncInterval"]];
    [syncerSettings addObject:@[@"textField", @"", @"", @"", @"syncServerURI"]];
    [syncerSettings addObject:@[@"textField", @"", @"", @"", @"xmlNamespace"]];
    
    [controlsSettings setValue:syncerSettings forKey:@"syncer"];
    
    
    NSMutableArray *generalSettings = [NSMutableArray array];
    [generalSettings addObject:@[@"switch", @"", @"", @"", @"localAccessToSettings"]];
    
    [controlsSettings setValue:generalSettings forKey:@"general"];
    
    
    NSMutableArray *batteryTrackerSettings = [NSMutableArray array];
    [batteryTrackerSettings addObject:@[@"switch", @"", @"", @"", @"batteryTrackerAutoStart"]];
    [batteryTrackerSettings addObject:@[@"slider", @"0", @"24", @"0.5", @"batteryTrackerStartTime"]];
    [batteryTrackerSettings addObject:@[@"slider", @"0", @"24", @"0.5", @"batteryTrackerFinishTime"]];
    
    [controlsSettings setValue:batteryTrackerSettings forKey:@"battery"];
    
    NSArray *groupNames = [NSArray arrayWithObjects:@"general", @"location", @"battery", @"map", @"syncer", nil];
    [controlsSettings setValue:groupNames forKey:@"groupNames"];
    
    //    NSLog(@"controlsSettings %@", controlsSettings);
    return controlsSettings;
}

@end
