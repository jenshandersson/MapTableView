//
//  MapLocation.m
//  MapTableView
//
//  Created by Jens Andersson on 2/18/13.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import "MapLocation.h"

@implementation MapLocation

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *)subtitle {
    return _address;
}

@end
