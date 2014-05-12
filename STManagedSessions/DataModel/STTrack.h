//
//  STTrack.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 12/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STComment.h"

@class STLocation;

@interface STTrack : STComment

@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * finishTime;
@property (nonatomic, retain) NSSet *locations;
@end

@interface STTrack (CoreDataGeneratedAccessors)

- (void)addLocationsObject:(STLocation *)value;
- (void)removeLocationsObject:(STLocation *)value;
- (void)addLocations:(NSSet *)values;
- (void)removeLocations:(NSSet *)values;

@end
