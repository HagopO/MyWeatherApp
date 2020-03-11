//
//  ForecastTableViewController.h
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/5/20.
//  Copyright © 2020 Proximie. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CurrentWeatherModel, CitiesUISearchViewController, SearchResultsTableViewController;

// protocol used to notify view when the model changes
@protocol UIUpdateDelegate
@required
    -(void)triggerUIUpdate: (CurrentWeatherModel*) newModel;
@end

@interface ForecastTableViewController : UITableViewController <UIUpdateDelegate, UIScrollViewDelegate>

-(id)init;
-(void)calculateUIFrames; // calculate UI frames
-(void)setupUIElements; // setup UI elements and their properties
-(void)setupSearchBarElements; //setup searchbar and related items

@property (nonatomic, strong) CitiesUISearchViewController* searchController;
@property (nonatomic, strong) SearchResultsTableViewController* searchTableViewController;

@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) CGRect headerFrame;

@property (nonatomic, strong) UILabel* cityLabel;
@property (nonatomic, strong) UILabel* temperatureLabel;
@property (nonatomic, strong) UILabel* feelsLikeLabel;
@property (nonatomic, strong) UILabel* windSpeedLabel;
@property (nonatomic, strong) UILabel* humidityLabel;
@property (nonatomic, strong) UIImageView* weatherIconImageView;
@property (nonatomic, strong) UILabel* weatherConditionsLabel;

@property (nonatomic, assign) CGRect cityLabelFrame;
@property (nonatomic, assign) CGRect temperatureLabelFrame;
@property (nonatomic, assign) CGRect feelsLikeLabelFrame;
@property (nonatomic, assign) CGRect windSpeedLabelFrame;
@property (nonatomic, assign) CGRect humidityLabelFrame;
@property (nonatomic, assign) CGRect weatherIconFrame;
@property (nonatomic, assign) CGRect weatherConditionsFrame;

@end

NS_ASSUME_NONNULL_END
