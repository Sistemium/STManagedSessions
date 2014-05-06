//
//  STViewController.m
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STViewController.h"
#import "STSessionManager.h"

@interface STViewController ()

@property (nonatomic, strong) STSessionManager *sessionManager;

@end

@implementation STViewController

- (STSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [STSessionManager sharedManager];
    }
    
    return _sessionManager;
    
}

- (void)customInit {
    
    [self.sessionManager startSessionForUID:@"1" authDelegate:nil controllers:nil settings:nil documentPrefix:@"test"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customInit];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
