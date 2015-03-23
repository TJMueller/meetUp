//
//  DetailViewController.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "CommentViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventRSVPLabel;
@property (strong, nonatomic) IBOutlet UILabel *hostInfoLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webViewTrial;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //NSDictionary *meetupVenue = [self.individualMeetUp objectForKey:@"venue"];
    NSDictionary *hostInfo = [self.individualMeetUp objectForKey:@"group"];

    self.eventNameLabel.text = [self.individualMeetUp objectForKey:@"name"];
    self.eventRSVPLabel.text = [[self.individualMeetUp objectForKey:@"yes_rsvp_count"]stringValue];
    self.hostInfoLabel.text = [hostInfo objectForKey:@"name"];
    [self.webViewTrial loadHTMLString:[self.individualMeetUp objectForKey:@"description"] baseURL:nil];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"WebPage"]) {
        WebViewController *vc = segue.destinationViewController;
        vc.urlString = [self.individualMeetUp objectForKey:@"event_url"];
    } else {
    CommentViewController *vc = segue.destinationViewController;
        NSDictionary *group = [self.individualMeetUp objectForKey:@"group"];
    vc.groupID = [group objectForKey:@"id"];
    }
}



@end
