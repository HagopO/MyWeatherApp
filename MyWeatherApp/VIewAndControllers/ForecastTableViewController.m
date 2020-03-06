//
//  ForecastTableViewController.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/5/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "ForecastTableViewController.h"

@interface ForecastTableViewController()

@end

@implementation ForecastTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerFrame = [[UIScreen  mainScreen] bounds];
    // setup table headers, UI frames and layout
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithWhite: 1 alpha: 0.25];
    self.tableView.pagingEnabled = YES;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self calculateUIFrames];
    [self setupUIElements];
}

#pragma mark - Table Layout

- (void)calculateUIFrames {
    const CGFloat uiInset = 25;
    const CGFloat temperatureLabelHeight = 110;
    const CGFloat otherViewsHeight = 40;
    
    // calculate the frames of UI elements in the table
    self.cityLabelFrame = CGRectMake(0, 20, self.headerFrame.size.width, otherViewsHeight);
    
    self.temperatureLabelFrame = CGRectMake (uiInset, self.headerFrame.size.height - (temperatureLabelHeight + otherViewsHeight + uiInset), self.headerFrame.size.width - (2 * uiInset), temperatureLabelHeight);
    
    self.highLowLabelFrame = CGRectMake (uiInset, self.headerFrame.size.height - (otherViewsHeight + uiInset), self.headerFrame.size.width - (2 * uiInset), otherViewsHeight);
    
    self.weatherIconFrame = CGRectMake (uiInset, self.temperatureLabelFrame.origin.y - (otherViewsHeight + uiInset), otherViewsHeight, otherViewsHeight);
    
    self.weatherConditionsFrame  = CGRectMake (self.weatherIconFrame.origin.x + otherViewsHeight + 10, self.temperatureLabelFrame.origin.y - (otherViewsHeight + uiInset), self.headerFrame.size.width - ((2 * uiInset) + otherViewsHeight + 10), otherViewsHeight);
}

- (void)setupUIElements {
    UIView* headerView = [[UIView alloc] initWithFrame: self.headerFrame];
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
    // temperature label goes to the bottom left
    self.temperatureLabel = [[UILabel alloc] initWithFrame: self.temperatureLabelFrame];
    self.temperatureLabel.backgroundColor = [UIColor clearColor];
    self.temperatureLabel.font = [UIFont fontWithName: @"Helvetica" size: 120];
    self.temperatureLabel.attributedText = [[NSAttributedString alloc] initWithString: @"0°" attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor], NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    [headerView addSubview: self.temperatureLabel];
    
    // high low label also goes to the bottom left
    self.highLowLabel = [[UILabel alloc] initWithFrame: self.highLowLabelFrame];
    self.highLowLabel.backgroundColor = [UIColor clearColor];
    self.highLowLabel.font = [UIFont fontWithName: @"Helvetica-Light" size: 30];
    self.highLowLabel.attributedText = [[NSAttributedString alloc] initWithString: @"0° / 0°" attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    [headerView addSubview: self.highLowLabel];
    
    // weather conditions label goes to top
    self.weatherConditionsLabel = [[UILabel alloc] initWithFrame: self.weatherConditionsFrame];
    self.weatherConditionsLabel.backgroundColor = [UIColor clearColor];
    self.weatherConditionsLabel.font = [UIFont fontWithName: @"Helvetica" size: 30];
    self.weatherConditionsLabel.attributedText = [[NSAttributedString alloc] initWithString: @"Rainy" attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    [headerView addSubview: self.weatherConditionsLabel];
    
    // weather conditions label goes to top
    self.weatherIconImageView = [[UIImageView alloc] initWithFrame: self.weatherIconFrame];
    self.weatherIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.weatherIconImageView.backgroundColor = [UIColor blackColor];
    [headerView addSubview: self.weatherIconImageView];
    
    // finally we add the city label
    self.cityLabel = [[UILabel alloc] initWithFrame: self.cityLabelFrame];
    self.cityLabel.backgroundColor = [UIColor clearColor];
    self.cityLabel.font = [UIFont fontWithName: @"Helvetica" size: 25];
    self.cityLabel.attributedText = [[NSAttributedString alloc] initWithString: @"Wuhan..." attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview: self.cityLabel];
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: cellIdentifier];
    }
    
    // setup cell selectionstyle and colors
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite: 0 alpha: 0.25];
    cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor whiteColor];

    return 0;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // determine cell height based on screen
    return 44;
}

@end
