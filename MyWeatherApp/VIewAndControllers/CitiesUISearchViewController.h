//
//  CitiesUISearchViewController.h
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/10/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// extended searchcontroller to provide isFiltering method
@interface CitiesUISearchViewController : UISearchController

-(BOOL)isSearchBarFiltering;

@end

NS_ASSUME_NONNULL_END
