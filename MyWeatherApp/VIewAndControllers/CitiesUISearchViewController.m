//
//  CitiesUISearchViewController.m
//  MyWeatherApp
//
//  Created by Jocelyne Abi Haidar on 3/10/20.
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
}

#pragma - Searchbar

-(BOOL)isSearchBarEmpty {
    return [self.searchBar.text isEqualToString: @""];
}

-(BOOL)isSearchBarFiltering {
    return (self.isActive && self.isSearchBarEmpty == NO);
}

@end
