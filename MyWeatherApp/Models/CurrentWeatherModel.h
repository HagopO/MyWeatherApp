//
//  currentWeatherModel.h
//  MyWeatherApp
//
//  Created by Mountain Lion on 3/6/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrentWeatherModel : NSObject
-(id)init;
-(BOOL)isNightTime: (NSTimeInterval)localTime;

@property (nonatomic, strong) NSString* locationString;
@property (nonatomic, strong) NSString* locationTypeString;
@property (nonatomic, strong) NSString* currentTemperatureString;
@property (nonatomic, strong) NSString* feelsLikeTemperatureString;
@property (nonatomic, assign) NSTimeInterval locationTime;

@property (nonatomic, assign) NSInteger windSpeed;
@property (nonatomic, assign) NSInteger humidity;
@property (nonatomic, strong) NSMutableArray* weatherConditionsArray;
@property (nonatomic, strong) NSMutableArray* weatherConditionIconsArray;

@end

NS_ASSUME_NONNULL_END
