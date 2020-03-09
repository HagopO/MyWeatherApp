//
//  ForecastTableViewController.h
//  MyWeatherApp
//
//  Created by Mountain Lion on 3/5/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForecastTableViewController : UITableViewController

@property (nonatomic, assign) CGFloat screenHeight; // used in paging calculations
@property (nonatomic, assign) CGRect headerFrame;

@property (nonatomic, assign) CGRect cityLabelFrame;
@property (nonatomic, assign) CGRect temperatureLabelFrame;
@property (nonatomic, assign) CGRect highLowLabelFrame;
@property (nonatomic, assign) CGRect weatherIconFrame;
@property (nonatomic, assign) CGRect weatherConditionsFrame;

@property (nonatomic, strong) UILabel* cityLabel;
@property (nonatomic, strong) UILabel* temperatureLabel;
@property (nonatomic, strong) UILabel* highLowLabel;
@property (nonatomic, strong) UIImageView* weatherIconImageView;
@property (nonatomic, strong) UILabel* weatherConditionsLabel;

@end

NS_ASSUME_NONNULL_END
