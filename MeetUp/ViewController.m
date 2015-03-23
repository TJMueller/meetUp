//
//  ViewController.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *meetUpArray;
@property NSDictionary *details;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2414741f5d2733a5044ae353a577e"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.details = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
                                           self.meetUpArray = [self.details objectForKey:@"results"];
                                           [self.tableView reloadData];
                                       }];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailViewController *vc = segue.destinationViewController;
    vc.individualMeetUp = [self.meetUpArray objectAtIndex:indexPath.row];



}



@end
