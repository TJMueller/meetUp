//
//  Event.h
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Event : NSObject
@property NSString *name;
@property NSString *location;
@property NSString *RSVP;
@property NSString *hostInfo;
@property NSString *eventDescription;
@property NSString *groupID;
@property NSString *urlString;

-(instancetype)initWithFullName:(NSString *)name andClothingITem:(NSString *)clothingItem;

@end
