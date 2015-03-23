
//
//  CommentViewController.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&group_id=1772396&key=2414741f5d2733a5044ae353a577e

    self.apiURL = @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=2414741f5d2733a5044ae353a577e";
    NSURL *url = [NSURL URLWithString:self.apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.details = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
                                           self.meetUpArray = [self.details objectForKey:@"results"];
                                           [self.tableView reloadData];
                                       }];
    


}



@end
