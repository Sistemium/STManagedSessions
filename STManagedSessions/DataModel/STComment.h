//
//  STComment.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STDatum.h"

@class STDatum;

@interface STComment : STDatum

@property (nonatomic, retain) NSString * commentText;
@property (nonatomic, retain) STDatum *owner;

@end
