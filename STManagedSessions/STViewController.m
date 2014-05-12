//
//  STViewController.m
//  STManagedSessions
//
//  Created by Maxim Grigoriev on 06/05/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "STViewController.h"
#import "STSessionManager.h"
#import <CoreLocation/CoreLocation.h>
#import "STSettingsTVC.h"
#import <KiteJSONValidator/KiteJSONValidator.h>

#define UID @"1"

@interface STViewController ()

@property (nonatomic, strong) STSessionManager *sessionManager;
@property (nonatomic, strong) id <STSession> session;
@property (weak, nonatomic) IBOutlet UIButton *logButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@end

@implementation STViewController

- (IBAction)logButtonPressed:(id)sender {
    
    UITableViewController *logTVC = [[UITableViewController alloc] init];
    logTVC.tableView.delegate = self.session.logger;
    logTVC.tableView.dataSource = self.session.logger;
    self.session.logger.tableView = logTVC.tableView;
    [self.navigationController pushViewController:logTVC animated:YES];

}

- (IBAction)locationButtonPressed:(id)sender {
}

- (IBAction)settingsButtonPressed:(id)sender {
    
    STSettingsTVC *settingsTVC = [[STSettingsTVC alloc] init];
    settingsTVC.session = self.session;
    [self.navigationController pushViewController:settingsTVC animated:YES];
    
}


- (STSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [STSessionManager sharedManager];
    }
    
    return _sessionManager;
    
}

- (void)sessionStatusChanged:(NSNotification *)notification {
    
    if ([notification.object conformsToProtocol:@protocol(STSession)]) {
        
        id <STSession> session = notification.object;
        
        if ([session.uid isEqualToString:UID] && [session.status isEqualToString:@"running"]) {
            
            self.session = session;
            [self enableButtons];
            
        }
        
    }
    
}

- (void)enableButtons {
    
    self.logButton.enabled = YES;
    self.locationButton.enabled = YES;
    self.settingsButton.enabled = YES;

}

- (void)customInit {
    
    self.logButton.enabled = NO;
    self.locationButton.enabled = NO;
    self.settingsButton.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStatusChanged:) name:@"sessionStatusChanged" object:nil];

    NSArray *trackers = [NSArray arrayWithObjects:@"battery", @"location", nil];
    NSDictionary *startSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSString stringWithFormat:@"%d", YES], @"batteryTrackerAutoStart",
                                        @"8.0", @"batteryTrackerStartTime",
                                        @"20.0", @"batteryTrackerFinishTime",
                                        [NSString stringWithFormat:@"%d", YES], @"locationTrackerAutoStart",
                                        @"8.0", @"locationTrackerStartTime",
                                        @"20.0", @"locationTrackerFinishTime",
                                        [NSString stringWithFormat:@"%f", kCLDistanceFilterNone], @"distanceFilter",
                                        @"0", @"requiredAccuracy",
                                     nil];
    
    [self.sessionManager startSessionForUID:UID authDelegate:nil trackers:trackers startSettings:startSettings defaultSettingsFileName:@"settings" documentPrefix:@"test"];
    
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
