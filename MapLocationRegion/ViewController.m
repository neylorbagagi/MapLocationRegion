//
//  ViewController.m
//  MapLocationRegion
//
//  Created by Neylor Bagagi on 11/26/15.
//  Copyright © 2015 Neylor Bagagi. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@end

@implementation ViewController{
    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc]init];
    [locationManager setDelegate:self];
    
    switch ([[locationManager class] authorizationStatus]) {
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            [locationManager requestWhenInUseAuthorization];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            
            [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            [locationManager setDistanceFilter:kCLDistanceFilterNone];
            
            [_latitudeLabel setText:[NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude]];
            [_longitudeLabel setText:[NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude]];
            
            [locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
            break;
        default:
            break;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [_latitudeLabel setText:[NSString stringWithFormat:@"%f",locations.lastObject.coordinate.latitude]];
    [_longitudeLabel setText:[NSString stringWithFormat:@"%f",locations.lastObject.coordinate.longitude]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
