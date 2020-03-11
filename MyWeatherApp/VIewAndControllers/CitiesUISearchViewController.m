//
//  CitiesUISearchViewController.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/10/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "CitiesUISearchViewController.h"

@interface CitiesUISearchViewController ()

-(BOOL)isSearchBarEmpty;

@end

@implementation CitiesUISearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog (@"%@ viewDidLoad", self);
}

#pragma - Searchbar

-(BOOL)isSearchBarEmpty {
    return [self.searchBar.text isEqualToString: @""];
}

-(BOOL)isSearchBarFiltering {
    return (self.isActive && self.isSearchBarEmpty == NO);
}

@end
