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
#import <TSMessage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [TSMessage setDefaultViewController: self];
    ForecastTableViewController* forecastTableViewController = [[ForecastTableViewController alloc] init];
    self.forecastTableViewController = forecastTableViewController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    
    self.backgroundImageView.frame = screenBounds;
    self.blurredImageView.frame = screenBounds;

    blurEffectView.frame = self.blurredImageView.bounds;
    [self.blurredImageView addSubview: blurEffectView];
    
    [self.view addSubview: self.forecastTableViewController.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    // notify the UI that results were received from the server
    [[APIManager sharedInstance] getCurrentWeather:^(CurrentWeatherModel* result, BOOL error) {
        if (error == NO) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CurrentWeatherModel* newModel = result;
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
            });
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
