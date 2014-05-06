//
//  STDocument.h
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface STDocument : UIManagedDocument

@property(nonatomic, strong, readonly) NSManagedObjectModel *myManagedObjectModel;

+ (STDocument *)documentWithUID:(NSString *)uid dataModelName:(NSString *)dataModelName prefix:(NSString *)prefix;

- (void)saveDocument:(void (^)(BOOL success))completionHandler;

@end
