//
//  STLogMessage.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "STComment.h"


@interface STLogMessage : STComment

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * type;

@end
