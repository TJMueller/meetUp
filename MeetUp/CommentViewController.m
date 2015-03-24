
//
//  CommentViewController.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentDetailViewController.h"

@interface CommentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSString *apiURL;
@property NSArray *commentArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSDictionary *details;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&group_id=1772396&key=2414741f5d2733a5044ae353a577e

    self.apiURL =[NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&group_id=%@&key=2414741f5d2733a5044ae353a577e", self.groupID];
    NSURL *url = [NSURL URLWithString:self.apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.details = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
                                           self.commentArray = [self.details objectForKey:@"results"];
                                           [self.tableView reloadData];
                                       }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
    //self.commentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentID"];
    NSDictionary *individualComments = [self.commentArray objectAtIndex:indexPath.row];
//    NSDictionary *meetupVenue = [individualMeetUps objectForKey:@"venue"];
    cell.textLabel.text = [individualComments objectForKey:@"member_name"];
    cell.detailTextLabel.text = [individualComments objectForKey:@"comment"];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CommentDetailViewController *vc = segue.destinationViewController;
    vc.individualComment = [self.commentArray objectAtIndex:indexPath.row];
}


@end
