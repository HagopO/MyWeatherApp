//
//  ViewController.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/4/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "ViewController.h"
#import "CurrentWeatherModel.h"
#import "ForecastTableViewController.h"
#import "APIManager.h"
#import <Toast.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    // init main controller and all related UI elements
    ForecastTableViewController* forecastTableViewController = [[ForecastTableViewController alloc] init];
    self.forecastTableViewController = forecastTableViewController;
    
    self.backgroundImageView.frame = self.blurredImageView.frame = screenBounds;
    
    // to receive update notification when service call is completed
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(receiveUpdateNotification:) name: @"UpdateViews" object: nil];
    
    // notifications to blur background image
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(receiveUpdateNotification:) name: @"ScrollBegan" object: nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.view addSubview: self.forecastTableViewController.tableView];
    
    // add blur effect to blurred image view
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    blurEffectView.frame = self.blurredImageView.bounds;
    [self.blurredImageView addSubview: blurEffectView];
    NSLog (@"%@ viewWillAppear", self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    // make initial call with default city
    [[APIManager sharedInstance] getCurrentWeather: @"Beirut" completionBlock:^(CurrentWeatherModel* result, BOOL error) {
        if (error == NO) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateViewsWithResult: result];
            });
        }
        else {
            // display a toast message about the error
            [self.view makeToast: @"An error occured. Please check if you are connected to the internet and try again" duration: 3.0 position: CSToastPositionCenter];
        }
    }];
        NSLog (@"%@ viewDidAppear", self);
}

// blur or unblur background image depending on whether scrolling started or stopped
-(void)scrollStatusChanged: (BOOL)scrollingBegan {
    if (scrollingBegan == YES) {
        self.backgroundImageView.alpha = 0.5;
        self.blurredImageView.alpha = 1;
        NSLog (@"Scrolling Began");
    }
    else { // notification called only when scrolling began or ended
        self.backgroundImageView.alpha = 1;
        self.blurredImageView.alpha = 0;
        NSLog (@"Scrolling Stopped");
    }
}

// receive either an API call completion notification or a scrolling notification and handle accordingly
-(void)receiveUpdateNotification: (NSNotification*)notificaiton {
    NSDictionary* dict = notificaiton.userInfo;
    
    // handle notifications for api call completion
    if ([notificaiton.name isEqualToString: @"UpdateViews"]) {
        NSLog (@"Update UI notification received");
        CurrentWeatherModel* newModel = [dict valueForKey: @"result"];
        
        if ([newModel isKindOfClass: [CurrentWeatherModel class]]) {
            [self updateViewsWithResult: newModel];
        }
        else { // error occured
            [self.view makeToast: @"An error occured. Please check if you are connected to the internet and try again" duration: 3.0 position: CSToastPositionCenter];
        }
    }
    
    // handle notifications for scroll start/end
    if ([notificaiton.name isEqualToString: @"ScrollBegan"]) {
        NSLog (@"Scroll start/end notification received");
        BOOL didStartScrolling = [[dict valueForKey: @"start"] boolValue];
        [self scrollStatusChanged: didStartScrolling];
    }
}

// update UI elements using new model values
-(void)updateViewsWithResult: (CurrentWeatherModel*) newModel {
    NSString* newBackgroundImageName = @"";
    [self.forecastTableViewController triggerUIUpdate: newModel];
    
    // change background wallpaper depending on whether its night at the location or not
    if ([newModel isNightTime: newModel.locationTime] == YES) {
        newBackgroundImageName = @"Night.png";
    }
    else {
        newBackgroundImageName = @"Day.png";
    }
    
    [UIView transitionWithView: self.backgroundImageView
                      duration: 0.5
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.backgroundImageView.image = [UIImage imageNamed: newBackgroundImageName];
                    } completion: nil];
    [UIView transitionWithView: self.blurredImageView
                      duration: 0.5
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.blurredImageView.image = [UIImage imageNamed: newBackgroundImageName];
                    } completion: nil];
    
    [self.view setNeedsDisplay];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
