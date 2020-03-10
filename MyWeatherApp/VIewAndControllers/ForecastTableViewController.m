//
//  ForecastTableViewController.m
//  MyWeatherApp
//
//  Created by Hagop Ohanessian on 3/5/20.
//  Copyright © 2020 Proximie. All rights reserved.
//

#import "ForecastTableViewController.h"
#import "CurrentWeatherModel.h"
#import "SearchResultsTableViewController.h"
#import "CitiesUISearchViewController.h"

@interface ForecastTableViewController()

@end

@implementation ForecastTableViewController

-(id)init {
    if (self = [super init]) {
    }
    return self;
}

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

#pragma mark -- Protocol required method implementation
-(void)triggerUIUpdate: (CurrentWeatherModel*)newModel {
    UIColor* textStrokeColor = [UIColor blackColor];
    UIColor* textForegroundColor = [UIColor whiteColor];
    
    if (newModel != nil) {
        if ([newModel isNightTime: newModel.locationTime] == YES) {
            textStrokeColor = [UIColor blueColor];
            textForegroundColor = [UIColor whiteColor];
        }
        else {
            textStrokeColor = [UIColor whiteColor];
            textForegroundColor = [UIColor blackColor];
        }
            
        // city
        [UIView transitionWithView: self.cityLabel
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.cityLabel.attributedText = [[NSAttributedString alloc] initWithString: newModel.locationString attributes:@{ NSStrokeColorAttributeName: textStrokeColor,  NSForegroundColorAttributeName: textForegroundColor, NSStrokeWidthAttributeName: @-2.0}];
                        } completion: nil];
        // current temperature
        [UIView transitionWithView: self.temperatureLabel
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.temperatureLabel.attributedText = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"%@°", newModel.currentTemperatureString] attributes:@{ NSStrokeColorAttributeName: textStrokeColor,  NSForegroundColorAttributeName: textForegroundColor, NSStrokeWidthAttributeName: @-2.0}];
                        } completion: nil];
        // feels like
        [UIView transitionWithView: self.feelsLikeLabel
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.feelsLikeLabel.attributedText = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"Feels Like: %@°", newModel.feelsLikeTemperatureString] attributes:@{ NSStrokeColorAttributeName: textStrokeColor,  NSForegroundColorAttributeName: textForegroundColor, NSStrokeWidthAttributeName: @-2.0}];
                        } completion: nil];
        // wind speed
        [UIView transitionWithView: self.windSpeedLabel
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.windSpeedLabel.attributedText = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"Wind Speed: %li km/h", newModel.windSpeed] attributes:@{ NSStrokeColorAttributeName: textStrokeColor,  NSForegroundColorAttributeName: textForegroundColor, NSStrokeWidthAttributeName: @-2.0}];
                        } completion: nil];
        // humidity level
        [UIView transitionWithView: self.humidityLabel
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.humidityLabel.attributedText = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"Humidity: %li %%", newModel.humidity] attributes:@{ NSStrokeColorAttributeName: textStrokeColor,  NSForegroundColorAttributeName: textForegroundColor, NSStrokeWidthAttributeName: @-2.0}];
                        } completion: nil];
        // weather conditions
        [UIView transitionWithView: self.weatherConditionsLabel
                          duration: 0.5
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.weatherConditionsLabel.attributedText = [[NSAttributedString alloc] initWithString: newModel.weatherConditionsArray.firstObject attributes:@{ NSStrokeColorAttributeName: textStrokeColor,  NSForegroundColorAttributeName: textForegroundColor, NSStrokeWidthAttributeName: @-2.0}];
                        } completion: nil];
    }
    
    NSURL* weatherIconImageURL = [NSURL URLWithString: newModel.weatherConditionIconsArray.firstObject];
    NSData* data = [NSData dataWithContentsOfURL: weatherIconImageURL];
    [self.weatherIconImageView setImage: [UIImage imageWithData: data]];
    
    [self.view setNeedsDisplay];
}

#pragma mark - Table Layout

- (void)calculateUIFrames {
    const CGFloat uiInset = 25;
    const CGFloat temperatureLabelHeight = 110;
    const CGFloat otherViewsHeight = 40;
    
    // calculate the frames of UI elements in the table
    self.cityLabelFrame = CGRectMake(0, 80, self.headerFrame.size.width, otherViewsHeight);
    
    self.temperatureLabelFrame = CGRectMake (uiInset, self.headerFrame.size.height - (temperatureLabelHeight + otherViewsHeight + uiInset), self.headerFrame.size.width - (2 * uiInset), temperatureLabelHeight);
    
    self.feelsLikeLabelFrame = CGRectMake (uiInset, self.headerFrame.size.height - (otherViewsHeight + uiInset), self.headerFrame.size.width - (2 * uiInset), otherViewsHeight);
    
    self.weatherIconFrame = CGRectMake (uiInset, self.temperatureLabelFrame.origin.y - (otherViewsHeight + uiInset), otherViewsHeight, otherViewsHeight);
    
    self.weatherConditionsFrame  = CGRectMake (self.weatherIconFrame.origin.x + otherViewsHeight + 10, self.temperatureLabelFrame.origin.y - (otherViewsHeight + uiInset), self.headerFrame.size.width - ((2 * uiInset) + otherViewsHeight + 10), otherViewsHeight);
    
    self.windSpeedLabelFrame = CGRectMake (uiInset, self.weatherConditionsFrame.origin.y - (otherViewsHeight + uiInset), self.headerFrame.size.width, otherViewsHeight);
    
    self.humidityLabelFrame = CGRectMake (uiInset, self.windSpeedLabelFrame.origin.y - (otherViewsHeight + uiInset), self.headerFrame.size.width, otherViewsHeight);
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
    
    // feels like label also goes to the bottom left
    self.feelsLikeLabel = [[UILabel alloc] initWithFrame: self.feelsLikeLabelFrame];
    self.feelsLikeLabel.backgroundColor = [UIColor clearColor];
    self.feelsLikeLabel.font = [UIFont fontWithName: @"Helvetica-Light" size: 30];
    self.feelsLikeLabel.attributedText = [[NSAttributedString alloc] initWithString: @"Feels Like:" attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    [headerView addSubview: self.feelsLikeLabel];
    
    // weather conditions label
    self.weatherConditionsLabel = [[UILabel alloc] initWithFrame: self.weatherConditionsFrame];
    self.weatherConditionsLabel.backgroundColor = [UIColor clearColor];
    self.weatherConditionsLabel.font = [UIFont fontWithName: @"Helvetica" size: 25];
    self.weatherConditionsLabel.attributedText = [[NSAttributedString alloc] initWithString: @"" attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    [headerView addSubview: self.weatherConditionsLabel];
    
    // weather condition icon
    self.weatherIconImageView = [[UIImageView alloc] initWithFrame: self.weatherIconFrame];
    self.weatherIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.weatherIconImageView.backgroundColor = [UIColor clearColor];
    self.weatherIconImageView.alpha = 0.8;
    [headerView addSubview: self.weatherIconImageView];
    
    // add the city label
    self.cityLabel = [[UILabel alloc] initWithFrame: self.cityLabelFrame];
    self.cityLabel.backgroundColor = [UIColor clearColor];
    self.cityLabel.font = [UIFont fontWithName: @"Helvetica" size: 30];
    self.cityLabel.attributedText = [[NSAttributedString alloc] initWithString: @"Loading..." attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview: self.cityLabel];
    
    // add humidity and windspeed
    self.windSpeedLabel = [[UILabel alloc] initWithFrame: self.windSpeedLabelFrame];
    self.windSpeedLabel.backgroundColor = [UIColor clearColor];
    self.windSpeedLabel.font = [UIFont fontWithName: @"Helvetica" size: 25];
    self.windSpeedLabel.attributedText = [[NSAttributedString alloc] initWithString: @"Wind Speed: " attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    [headerView addSubview: self.windSpeedLabel];
    
    self.humidityLabel = [[UILabel alloc] initWithFrame: self.humidityLabelFrame];
    self.humidityLabel.backgroundColor = [UIColor clearColor];
    self.humidityLabel.font = [UIFont fontWithName: @"Helvetica" size: 25];
    self.windSpeedLabel.attributedText = [[NSAttributedString alloc] initWithString: @"Humidity: " attributes:@{ NSStrokeColorAttributeName: [UIColor whiteColor],  NSForegroundColorAttributeName: [UIColor blackColor], NSStrokeWidthAttributeName: @-2.0}];
    [headerView addSubview: self.humidityLabel];
    
    
    self.searchTableViewController = [[SearchResultsTableViewController alloc] initWithStyle: UITableViewStylePlain];
 
    
    self.searchController = [[CitiesUISearchViewController alloc] initWithSearchResultsController: self.searchTableViewController];
    self.searchController.searchResultsUpdater = self.searchTableViewController;
    self.navigationItem.searchController = self.searchController;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.delegate = self.searchTableViewController;
    
    self.searchTableViewController.tableView.delegate = self.searchTableViewController;
    self.searchTableViewController.tableView.dataSource = self.searchTableViewController;
    self.searchTableViewController.weakParent = self.searchController;
    self.searchTableViewController.tableView.backgroundColor = [UIColor clearColor];
    self.searchTableViewController.tableView.separatorColor = [UIColor whiteColor];
    
    [headerView addSubview: self.searchController.searchBar];
    [headerView bringSubviewToFront: self.searchController.searchResultsController.view];
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

    return cell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // determine cell height based on screen
    return 44;
}

@end
