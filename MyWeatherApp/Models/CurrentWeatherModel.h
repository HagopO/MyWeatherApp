//
//  currentWeatherModel.h
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/6/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// model for store part of the response object returned by current weather API
@interface CurrentWeatherModel : NSObject

-(id)init;
-(BOOL)isNightTime: (NSTimeInterval)localTime;

@property (nonatomic, strong) NSString* locationString; // name of city
@property (nonatomic, strong) NSString* locationTypeString; // city/town/etc
@property (nonatomic, strong) NSString* currentTemperatureString;
@property (nonatomic, strong) NSString* feelsLikeTemperatureString;
@property (nonatomic, assign) NSTimeInterval locationTime; // time at selected location

// additional info like windspeed, humidity, weather conditions
@property (nonatomic, assign) NSInteger windSpeed;
@property (nonatomic, assign) NSInteger humidity;
@property (nonatomic, strong) NSMutableArray* weatherConditionsArray;
@property (nonatomic, strong) NSMutableArray* weatherConditionIconsArray;

@end

NS_ASSUME_NONNULL_END
