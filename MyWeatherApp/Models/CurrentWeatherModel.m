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
        self.locationTimeString = @"";
        self.currentTemperatureString = @"";
        self.feelsLikeTemperatureString = @"";
        self.TimeZoneString = @"";

        self.windSpeed = self.humidity = 0;
        self.weatherConditionsArray = [[NSMutableArray alloc] initWithCapacity: 1];
        self.weatherConditionIconsArray = [[NSMutableArray alloc] initWithCapacity: 1];
    }
    return self;
}

// uses the TimeZone value returned by the API to generate a time for selected location
// and determine whether its nighttime or not
-(BOOL)isNightTime {
    // this implementation can be made more accurate by getting sunrise and sunset times and then using those to determine if its nighttime at a location. For the purpose of this excercise, a simpler implementation will be used.
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    
    timeFormatter.dateFormat = @"h:mm a";
    timeFormatter.timeZone = [NSTimeZone timeZoneWithName: self.TimeZoneString];
    
    // by getting the current time locally, and passing the timezone that we have from
    // the API, we will be getting the time at the selected location
    NSDate* currentDate = [NSDate date];
    NSString* date = [timeFormatter stringFromDate: currentDate];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone: timeFormatter.timeZone]; // set time zone for calendar too
    NSDateComponents* components = [calendar components: (NSCalendarUnitHour) fromDate: currentDate];
    
    NSInteger hour = [components hour];
    NSLog (@"%li", (long)hour);
    self.locationTimeString = date;
    
    switch (hour) {
        case 0: case 1: case 2: case 3: case 4: case 5: case 6:
        case 18: case 19: case 20: case 21: case 22: case 23:
            return YES;
        break;
    }
    return NO;
}

@end
