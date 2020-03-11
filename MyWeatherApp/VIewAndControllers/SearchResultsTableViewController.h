//
//  SearchResultsTableViewController.h
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/10/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CitiesUISearchViewController;

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic, assign) CitiesUISearchViewController* weakParent;
@property (nonatomic, strong) NSMutableArray* bunchOfCities;
@property (nonatomic, strong) NSMutableArray* filteredCities;

@end

NS_ASSUME_NONNULL_END
