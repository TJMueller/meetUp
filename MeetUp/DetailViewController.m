//
//  DetailViewController.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventRSVPLabel;
@property (strong, nonatomic) IBOutlet UILabel *hostInfoLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //NSDictionary *meetupVenue = [self.individualMeetUp objectForKey:@"venue"];
    NSDictionary *hostInfo = [self.individualMeetUp objectForKey:@"group"];

    self.eventNameLabel.text = [self.individualMeetUp objectForKey:@"name"];
    self.eventRSVPLabel.text = [[self.individualMeetUp objectForKey:@"yes_rsvp_count"]stringValue];
    self.hostInfoLabel.text = [hostInfo objectForKey:@"name"];
    self.descriptionTextField.text = [self.individualMeetUp objectForKey:@"description"];


}


@end
