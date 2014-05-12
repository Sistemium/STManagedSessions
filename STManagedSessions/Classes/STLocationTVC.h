//
//  STLocationTVC.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 12/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "STSessionManagement.h"

@interface STLocationTVC : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id <STSession> session;

@end
