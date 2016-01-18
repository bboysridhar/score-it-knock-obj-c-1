//
//  ViewController.m
//  KnockToReact
//
//  Created by Matheus Cavalca on 10/26/15.
//  Copyright © 2015 Matheus Cavalca. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SingletonLocation sharedInstance];
    [KnockHelper sharedInstance].delegate = self;
}

#pragma mark - Action methods
- (IBAction)plusButton_Touched:(id)sender {
    [[KnockHelper sharedInstance] incrementLimitDifference:0.1];
    self.sensitivityLabel.text = [NSString stringWithFormat:@"%.01f",[[KnockHelper sharedInstance] limitDifference]];
}

- (IBAction)minusButton_Touched:(id)sender {
    [[KnockHelper sharedInstance] decrementLimitDifference:0.1];
    self.sensitivityLabel.text = [NSString stringWithFormat:@"%.01f",[[KnockHelper sharedInstance] limitDifference]];
}

#pragma mark - KnockHelperDelegate
- (void)knockPerformed:(int)knockCount :(double)z :(double)milliseconds{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
//    NSString *message = [NSString stringWithFormat: @"Latitude: %f - Longitude: %f", [SingletonLocation sharedInstance].currentLocation.coordinate.latitude, [SingletonLocation sharedInstance].currentLocation.coordinate.longitude];
    NSString *message = [NSString stringWithFormat:@"Score: %d \n Z: %f \n MilliSeconds: %f", knockCount, z,milliseconds];
    [notification setAlertBody:message];
    [notification setSoundName:UILocalNotificationDefaultSoundName];
    [[UIApplication sharedApplication]  setScheduledLocalNotifications:[NSArray arrayWithObject:notification]];
}

@end