//
//  CommentDetailViewController.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "CommentDetailViewController.h"
#import "CommentDetailWebViewController.h"

@interface CommentDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *epochTime = [self.individualComment objectForKey:@"time"] ;
    NSLog(@"%@",epochTime );
    // Convert NSString to NSTimeInterval
    NSTimeInterval seconds = ([epochTime doubleValue]/1000);

    // (Step 1) Create NSDate object
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSLog (@"Epoch time %@ equates to UTC %@", epochTime, epochNSDate);

    // (Step 2) Use NSDateFormatter to display epochNSDate in local time zone
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSLog (@"Epoch time %@ equates to %@", epochTime, [dateFormatter stringFromDate:epochNSDate]);

    self.nameLabel.text = [self.individualComment objectForKey:@"member_name"];
    self.timeLabel.text = [dateFormatter stringFromDate:epochNSDate];
    self.commentLabel.text = [self.individualComment objectForKey:@"comment"];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        CommentDetailWebViewController *vc = segue.destinationViewController;
        vc.commentURL = [self.individualComment objectForKey:@"comment_url"];
}

@end
