//
//  SearchResultsTableViewController.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/10/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "CitiesUISearchViewController.h"
#import "APIManager.h"

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.bunchOfCities = [[[NSArray alloc] initWithObjects: @"Amsterdam", @"Beirut", @"Kabul", @"Sarajevo", @"Yerevan", nil] mutableCopy];
    self.filteredCities = [[NSMutableArray alloc] initWithCapacity: 0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.weakParent != nil) {
        if ([self.weakParent isSearchBarFiltering]) {
            return self.filteredCities.count;
        }
    }
    return self.bunchOfCities.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* currentCityString = [self.filteredCities objectAtIndex: indexPath.row];
    [self.weakParent setActive: NO];
    self.weakParent.searchBar.text = currentCityString;
    
    // make call with selected city
    [[APIManager sharedInstance] getCurrentWeather: currentCityString completionBlock:^(CurrentWeatherModel* result, BOOL error) {
        if (error == NO) {
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject: result forKey:   @"result"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateViews" object: nil userInfo: userInfo];
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString* cityNameString = @"";
    
    static NSString *cellIdentifier = @"cellIdentifier2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: cellIdentifier];
        
        // setup cell sealectionstyle and colors
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }

    if (self.weakParent != nil) {
        if ([self.weakParent isSearchBarFiltering]) {
            cityNameString = [self.filteredCities objectAtIndex: indexPath.row];
        }
        else {
            cityNameString = [self.bunchOfCities objectAtIndex: indexPath.row];
        }
    }
    
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString: cityNameString attributes:@{ NSStrokeColorAttributeName: [UIColor blackColor],  NSForegroundColorAttributeName: [UIColor whiteColor], NSStrokeWidthAttributeName: @-2.0}];
    
    return cell;
}

-(void)updateSearchResultsForSearchController:(CitiesUISearchViewController *)searchController {
    NSString* searchBarTextString = searchController.searchBar.text;
    
    if (searchBarTextString.length > 0) {
        [self.filteredCities removeAllObjects];
        [((UITableViewController*)searchController.searchResultsController).tableView becomeFirstResponder];
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id currentItem, NSDictionary *bindings) {
            NSLog(@"GOT STRINGL %@", currentItem);
            NSRange range = [currentItem rangeOfString: searchBarTextString options: NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];
    
        self.filteredCities = [[self.bunchOfCities filteredArrayUsingPredicate: predicate] mutableCopy];
        
       // [((UITableViewControll*)searchController.searchResultsController).tableVIew reloadData];
        [((UITableViewController*)searchController.searchResultsController).tableView reloadData];
    }
}

@end
