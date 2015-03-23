//
//  ViewController.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSArray *meetUpArray;
@property NSDictionary *details;
@property NSArray *searchResults;
@property NSString *apiURL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apiURL = @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2414741f5d2733a5044ae353a577e";
    NSURL *url = [NSURL URLWithString:self.apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.details = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
                                           self.meetUpArray = [self.details objectForKey:@"results"];
                                           [self.tableView reloadData];
                                       }];
    self.searchBar.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.meetUpArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meetUpID"];
    NSDictionary *individualMeetUps = [self.meetUpArray objectAtIndex:indexPath.row];
    NSDictionary *meetupVenue = [individualMeetUps objectForKey:@"venue"];
    cell.textLabel.text = [individualMeetUps objectForKey:@"name"];
    cell.detailTextLabel.text = [meetupVenue objectForKey:@"address_1"];
    return cell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.apiURL = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=2414741f5d2733a5044ae353a577e", self.searchBar.text];
    NSURL *url = [NSURL URLWithString:self.apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.details = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
                                           self.meetUpArray = [self.details objectForKey:@"results"];
                                           [self.tableView reloadData];
                                       }];
    [self.tableView reloadData];
    NSLog(@"search %@",self.apiURL);


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailViewController *vc = segue.destinationViewController;
    vc.individualMeetUp = [self.meetUpArray objectAtIndex:indexPath.row];
}





@end
