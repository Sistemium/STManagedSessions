//
//  STGTTracker.h
//  geotracker
//
//  Created by Maxim Grigoriev on 3/11/13.
//  Copyright (c) 2013 Maxim Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "STSessionManagement.h"
#import "STDocument.h"

@interface STTracker : NSObject

@property (nonatomic, strong) STDocument *document;
@property (nonatomic, strong) id <STSession> session;
@property (nonatomic, strong) NSMutableDictionary *settings;
@property (nonatomic, strong) NSString *group;
@property (nonatomic) BOOL tracking;
@property (nonatomic) BOOL trackerAutoStart;

- (void)customInit;
- (void)startTracking;
- (void)stopTracking;
- (void)prepareToDestroy;

@end
