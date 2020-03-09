//
//  APIManager.h
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/6/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RKObjectManager;

@interface APIManager : NSObject

+(instancetype)sharedInstance;

// API manager should NEVER be called with init. [APIManager sharedInstance] is the only
// way to ensure singleton behavior
-(instancetype)init NS_UNAVAILABLE;

-(void)getCurrentWeather;

@property (nonatomic, strong) RKObjectManager* restKitManager;

@property (nonatomic, strong) NSString* weatherStackBaseURLString;
@property (nonatomic, strong) NSString* weatherStackAPIAccessKeyString;
@property (nonatomic, strong) NSString* currentWeahterServiceURLString;

@end

NS_ASSUME_NONNULL_END
