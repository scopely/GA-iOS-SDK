//
//  BatchViewController.m
//  GA iOS Wrapper Demo
//
//  Created by Aleksandras Smirnovas on 3/6/13.
//  Copyright (c) 2013 Aleksandras Smirnovas. All rights reserved.
//

#import "BatchViewController.h"
#import "GameAnalytics.h"

@interface BatchViewController ()

@end

@implementation BatchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.toggleLogButton setTitle:@"Disable Debug Log" forState:UIControlStateNormal];
    [GameAnalytics setDebugLogEnabled:YES];
    [GameAnalytics setBatchRequestsEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logUserData:(id)sender
{
    [GameAnalytics logUserDataWithParams:@{@"gender" : @"M", @"birth_year" : @1981, @"country" : @"LT", @"state" : @"VNO", @"friend_count" : @10}];
}

-(IBAction)logBusinessData:(id)sender
{
    [GameAnalytics logBusinessDataEvent:@"PurchaseWeapon:Shotgun" withParams:@{@"area" : @"Level 1", @"x" : @1.0f, @"y" : @1.0f, @"z" : @1.0f, @"currency" : @"LTL", @"amount" : @1000 }];
}

-(IBAction)logGameDesingData:(id)sender
{
    [GameAnalytics logGameDesignDataEvent:@"PickedUpAmmo:Shotgun" withParams:@{@"area" : @"Level 1", @"x" : @1.0f, @"y" : @1.0f, @"z" : @1.0f, @"value" : @1.0f}];
}

-(IBAction)logQAData:(id)sender
{
    [GameAnalytics logQualityAssuranceDataEvent:@"Exceptaion:NullReferenceException" withParams:@{ @"area" : @"Level 1", @"x" : @1.0f, @"y" : @1.0f, @"z" : @1.0f, @"message" : @"at Infragistics.Windows.Internal.TileManager.ItemRowColumnSizeInfo.."}];
}

-(IBAction)toggleDebugLog:(id)sender
{
    if([self.toggleLogButton.titleLabel.text isEqualToString:@"Enable Debug Log"])
    {
        [self.toggleLogButton setTitle:@"Disable Debug Log" forState:UIControlStateNormal];
        [GameAnalytics setDebugLogEnabled:YES];
    } else {
        [self.toggleLogButton setTitle:@"Enable Debug Log" forState:UIControlStateNormal];
        [GameAnalytics setDebugLogEnabled:NO];
    }
}

-(IBAction)batchSend:(id)sender
{
    [GameAnalytics sendBatch];
}


@end
