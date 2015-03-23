//
//  Event.m
//  MeetUp
//
//  Created by Timothy Mueller on 3/23/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "Event.h"


@implementation Event

-(instancetype)initWithFullName:(NSString *)name andClothingITem:(NSString *)location
{
    self = [super init];
    if (self) {
        self.name = name;
        self.location = location;
    }
    return self;
}

@end
