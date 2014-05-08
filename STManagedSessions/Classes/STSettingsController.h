//
//  STHTSettingsController.h
//  geotracking
//
//  Created by Maxim Grigoriev on 1/24/13.
//  Copyright (c) 2013 Maxim V. Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "STSessionManagement.h"

@interface STSettingsController : NSObject <STSettingsController>

+ (STSettingsController *)initWithSettings:(NSDictionary *)startSettings;


- (NSDictionary *)defaultSettings;
- (NSArray *)currentSettings;
- (NSString *)normalizeValue:(NSString *)value forKey:(NSString *)key;
- (NSString *)addNewSettings:(NSDictionary *)newSettings forGroup:(NSString *)group;
- (NSMutableDictionary *)currentSettingsForGroup:(NSString *)group;

- (BOOL)isPositiveDouble:(NSString *)value;
- (BOOL)isBool:(NSString *)value;
- (BOOL)isValidTime:(NSString *)value;
- (BOOL)isValidURI:(NSString *)value;


@property (nonatomic, strong) NSMutableDictionary *startSettings;
@property (nonatomic, strong) id <STSession> session;

@end
