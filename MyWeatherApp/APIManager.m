//
//  APIManager.m
//  MyWeatherApp
//
//  Created by Mountain Lion on 3/6/20.
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
        self.weatherStackBaseURLString = @"http://api.weatherstack.com";
        self.weatherStackAPIAccessKeyString = @"b40ed7542b540bbb8badb511ddafa301";
        self.currentWeahterServiceURLString = @"/current";
        [self configureRestKit];
    }
    return self;
}

-(void)configureRestKit {
    NSURL *baseURL = [NSURL URLWithString: self.weatherStackBaseURLString];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    
    self.restKitManager = [[RKObjectManager alloc] initWithHTTPClient: client];
    
    // setup object mappings
    RKObjectMapping *weatherMapping = [RKObjectMapping mappingForClass: [CurrentWeatherModel class]];
    
    [weatherMapping addAttributeMappingsFromArray: @[@"temperature"]];
    
    RKResponseDescriptor* rDescriptor = [RKResponseDescriptor responseDescriptorWithMapping: weatherMapping method: RKRequestMethodGET pathPattern: self.currentWeahterServiceURLString keyPath: @"current" statusCodes: [NSIndexSet indexSetWithIndex: 200]];
    
    [self.restKitManager addResponseDescriptor: rDescriptor];
}

-(void)getCurrentWeather {
    NSDictionary* params = @{@"access_key": self.weatherStackAPIAccessKeyString, @"query": @"New York" };
    
    [self.restKitManager getObjectsAtPath: self.currentWeahterServiceURLString parameters: params success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
    }
    failure:^(RKObjectRequestOperation *operation, NSError* error) {
        NSLog (@"");
    }];
}

@end
