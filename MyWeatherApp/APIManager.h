//
//  APIManager.h
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/6/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RKObjectManager, CurrentWeatherModel;

@interface APIManager : NSObject

+(instancetype)sharedInstance;

// API manager should NEVER be called with init. [APIManager sharedInstance] is the only
// way to ensure singleton behavior
-(instancetype)init NS_UNAVAILABLE; // only available to API manager

// get current weather given a city name
-(void)getCurrentWeather: (NSString*)queryString completionBlock:(void (^) (CurrentWeatherModel *response, bool errorOccured)) handler;

@property (nonatomic, strong) RKObjectManager* restKitManager;

@property (nonatomic, strong) NSString* weatherStackBaseURLString; // weather stack url
@property (nonatomic, strong) NSString* weatherStackAPIAccessKeyString; // API key
@property (nonatomic, strong) NSString* currentWeatherWithForecastServiceURLString;

@end

NS_ASSUME_NONNULL_END
