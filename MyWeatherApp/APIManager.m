//
//  APIManager.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian 3/6/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "APIManager.h"
#import <RestKit/RestKit.h>
#import "CurrentWeatherModel.h"

@implementation APIManager

+(instancetype)sharedInstance {
    static APIManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init {
    if (self = [super init]) {
        // init base url, API key and service url
        self.weatherStackBaseURLString = @"http://api.weatherstack.com";
        self.weatherStackAPIAccessKeyString = @"b40ed7542b540bbb8badb511ddafa301";
        self.currentWeatherWithForecastServiceURLString = @"/forecast";
        [self configureRestKit];
    }
    return self;
}

// configures restkit with appropriate attribute mappings and response descriptor
-(void)configureRestKit {
    NSURL *baseURL = [NSURL URLWithString: self.weatherStackBaseURLString];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    
    // init restkit with http client
    self.restKitManager = [[RKObjectManager alloc] initWithHTTPClient: client];
    
    // setup object mappings
    RKObjectMapping *weatherMapping = [RKObjectMapping mappingForClass: [CurrentWeatherModel class]];
    
    [weatherMapping addAttributeMappingsFromDictionary: @{@"current.temperature" : @"currentTemperatureString"}];
    [weatherMapping addAttributeMappingsFromDictionary: @{@"location.name" : @"locationString"}];
    [weatherMapping addAttributeMappingsFromDictionary: @{@"current.feelslike" : @"feelsLikeTemperatureString"}];
    [weatherMapping addAttributeMappingsFromDictionary: @{@"location.timezone_id" : @"TimeZoneString"}];

    [weatherMapping addAttributeMappingsFromDictionary: @{@"current.wind_speed" : @"windSpeed"}];
    [weatherMapping addAttributeMappingsFromDictionary: @{@"current.humidity" : @"humidity"}];
    [weatherMapping addAttributeMappingsFromDictionary: @{@"current.weather_descriptions": @"weatherConditionsArray"}];
    [weatherMapping addAttributeMappingsFromDictionary: @{@"current.weather_icons" : @"weatherConditionIconsArray"}];
    
    RKResponseDescriptor* rDescriptor = [RKResponseDescriptor responseDescriptorWithMapping: weatherMapping method: RKRequestMethodGET pathPattern: self.currentWeatherWithForecastServiceURLString keyPath: nil statusCodes: [NSIndexSet indexSetWithIndex: 200]];
    
    [self.restKitManager addResponseDescriptor: rDescriptor];
}

// get current weather details given a city name
-(void)getCurrentWeather: (NSString*)queryString completionBlock:(void (^) (CurrentWeatherModel *response, bool errorOccured)) handler {
    NSDictionary* params = @{@"access_key": self.weatherStackAPIAccessKeyString, @"query": queryString};
    __block CurrentWeatherModel* returnedResult = [[CurrentWeatherModel alloc] init];
    
    [self.restKitManager getObjectsAtPath: self.currentWeatherWithForecastServiceURLString parameters: params success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        
        if (result != nil) {
            returnedResult = [result firstObject];
        }

        handler(returnedResult, NO);
        NSLog(@"API call succeeded. Result: %@",returnedResult);
    }
    failure:^(RKObjectRequestOperation *operation, NSError* error) {
        handler(returnedResult, YES); // returned result contains default values since error occured
        NSLog (@"Error retrieving results: Please make sure you are connected to the internet.");
    }];
}

@end
