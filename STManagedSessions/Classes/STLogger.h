//
//  STLogger.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STSessionManagement.h"

@interface STLogger : NSObject <STLogger, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id <STSession> session;
@property (nonatomic, weak) UITableView *tableView;

- (void)saveLogMessageWithText:(NSString *)text type:(NSString *)type;

@end
