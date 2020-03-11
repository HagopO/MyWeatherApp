//
//  ViewController.h
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/4/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForecastTableViewController;

@interface ViewController : UIViewController

// searchbar to search/filter by city
@property (nonatomic, strong) UISearchBar* searchBar;

// main controller that will display weather information
@property (nonatomic, strong) ForecastTableViewController* forecastTableViewController;

@property (nonatomic, strong) IBOutlet UIImageView* backgroundImageView;
@property (nonatomic, strong) IBOutlet UIImageView* blurredImageView;

@end

