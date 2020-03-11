//
//  currentWeatherModel.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/6/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "CurrentWeatherModel.h"

@implementation CurrentWeatherModel

-(id)init {
    if (self = [super init]) {
        self.locationString = @"";
        self.locationTypeString = @"";
        self.currentTemperatureString = @"";
        self.feelsLikeTemperatureString = @"";
        self.locationTime = (NSTimeInterval)0;

        self.windSpeed = self.humidity = 0;
        self.weatherConditionsArray = [[NSMutableArray alloc] initWithCapacity: 1];
        self.weatherConditionIconsArray = [[NSMutableArray alloc] initWithCapacity: 1];
    }
    return self;
}

-(BOOL)isNightTime: (NSTimeInterval)localTime {
    NSDate* localDate = [NSDate dateWithTimeIntervalSince1970: localTime];
    // this implementation can be made more accurate by getting sunrise and sunset times and then using those to determine if its nighttime at a location. For the purpose of this excercise, a simpler implementation will be used.
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"HH:mm:ss";
    NSDateComponents *components = [[NSCalendar currentCalendar] components: (NSCalendarUnitHour) fromDate: localDate];
    NSInteger hour = [components hour];
    NSLog (@"%li", (long)hour);
    return (hour > 6 && hour < 18) == NO;
}

@end
