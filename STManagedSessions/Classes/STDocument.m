//
//  STDocument.m
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STDocument.h"

@interface STDocument()

@property (nonatomic, strong) NSString *dataModelName;
@property (nonatomic) BOOL saving;

@end


@implementation STDocument

@synthesize myManagedObjectModel = _myManagedObjectModel;

- (NSManagedObjectModel *)myManagedObjectModel {
    
    if (!_myManagedObjectModel) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:self.dataModelName ofType:@"momd"];
        
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:self.dataModelName ofType:@"mom"];
        }
        
        NSURL *url = [NSURL fileURLWithPath:path];

        //        NSLog(@"path %@", path);
        //        NSLog(@"url %@", url);

        _myManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
        
    }
    
    return _myManagedObjectModel;
    
}

- (NSManagedObjectModel *)managedObjectModel {
    return self.myManagedObjectModel;
}

- (void)saveDocument:(void (^)(BOOL success))completionHandler {
    
    if (!self.saving) {

        if (self.documentState == UIDocumentStateNormal) {
            
            self.saving = YES;
            
            [self saveToURL:self.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
                
                if (success) {
                    NSLog(@"UIDocumentSaveForOverwriting success");
                    completionHandler(YES);
                } else {
                    NSLog(@"UIDocumentSaveForOverwriting not success");
                }
                self.saving = NO;
                
            }];
            
        } else {
            NSLog(@"documentState != UIDocumentStateNormal for document: %@", self);
            NSLog(@"documentState is %u", (int)self.documentState);
        }

    }

}

+ (STDocument *)initWithFileURL:(NSURL *)url andDataModelName:(NSString *)dataModelName {
    
    STDocument *document = [STDocument alloc];
    document.dataModelName = dataModelName;
    return [document initWithFileURL:url];
    
}

+ (STDocument *)documentWithUID:(NSString *)uid dataModelName:(NSString *)dataModelName prefix:(NSString *)prefix {
    
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@.%@", prefix, uid, @"sqlite"]];
    
    STDocument *document = [STDocument initWithFileURL:url andDataModelName:dataModelName];
    
    document.persistentStoreOptions = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[document.fileURL path]]) {

        [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            
            if (success) {
                NSLog(@"document UIDocumentSaveForCreating success");
                [self document:document readyWithUID:uid];
            } else {
                [self document:document notReadyWithUID:uid];
            }
            
        }];
        
    } else if (document.documentState == UIDocumentStateClosed) {
        
        [document openWithCompletionHandler:^(BOOL success) {
            
            if (success) {
                NSLog(@"document openWithCompletionHandler success");
                [self document:document readyWithUID:uid];
            } else {
                [self document:document notReadyWithUID:uid];
            }
            
        }];
        
    } else if (document.documentState == UIDocumentStateNormal) {
        
        [self document:document readyWithUID:uid];
        
    }
    
    return document;
    
}

+ (void)document:(STDocument *)document readyWithUID:(NSString *)uid {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"documentReady" object:document userInfo:[NSDictionary dictionaryWithObject:uid forKey:@"uid"]];

}

+ (void)document:(STDocument *)document notReadyWithUID:(NSString *)uid {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"documentNotReady" object:document userInfo:[NSDictionary dictionaryWithObject:uid forKey:@"uid"]];
    
}


@end
