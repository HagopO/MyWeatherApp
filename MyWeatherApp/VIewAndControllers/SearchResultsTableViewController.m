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
#import <Toast.h>

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // initially it was intended to use GooglePlacesAPI to get a list of places instead, but there
    // were billing procedures to follow. A small, fixed list of cities was used to simply demonstrate
    // searching and filtering functionalities
    self.bunchOfCities = [[[NSArray alloc] initWithObjects:
        @"Amman", @"Amsterdam",@"Ankara", @"Athens", @"Baghdad", @"Bangkok", @"Beijing", @"Beirut",
        @"Berlin", @"Brussels", @"Cairo", @"Copenhagen", @"Dakar", @"Damascus", @"Doha", @"Dublin",
        @"Georgetown", @"Hanoi", @"Helsinki", @"Islamabad", @"Jerusalem", @"Ramallah", @"Kabul",
        @"London", @"Moscow", @"Paris", @"Tehran", @"Tokyo", @"Vienna", @"Washington", nil] mutableCopy];
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
    self.weakParent.searchBar.text = @"";
    
    // make call with selected city
    [[APIManager sharedInstance] getCurrentWeather: currentCityString completionBlock:^(CurrentWeatherModel* result, BOOL error) {
        if (error == NO) {
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject: result forKey: @"result"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateViews" object: nil userInfo: userInfo];
        }
        else {
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject: @"0" forKey: @"result"];
            
            // send nil as result to indicate error occured
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
