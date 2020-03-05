//
//  ViewController.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/4/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "ViewController.h"
#import "ForecastTableViewController.h"

#import <TSMessage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [TSMessage setDefaultViewController: self];
    
    // setup forecast table
    ForecastTableViewController* forecastTableViewController = [[ForecastTableViewController alloc] init];
    
    [self.view addSubview: forecastTableViewController.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    
    blurEffectView.frame = self.blurredImageView.bounds;
    [self.blurredImageView addSubview: blurEffectView];
    
    // setup forecast table
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
