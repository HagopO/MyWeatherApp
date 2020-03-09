//
//  ForecastTableViewController.h
//  MyWeatherApp
//
//  Created by Mountain Lion on 3/5/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CurrentWeatherModel;

// protocol used to notify view when the model changes
@protocol UIUpdateDelegate
@required
    -(void)triggerUIUpdate: (CurrentWeatherModel*) newModel;
@end

@interface ForecastTableViewController : UITableViewController <UIUpdateDelegate>

-(id)init;

@property (nonatomic, assign) CGFloat screenHeight; // used in paging calculations
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
