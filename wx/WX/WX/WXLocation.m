//
//  WXLocation.m
//  WX
//
//  Created by hailong11 on 2018/11/12.
//  Copyright © 2018 kkmofang.cn. All rights reserved.
//

#import "WXLocation.h"
#include <objc/runtime.h>

@implementation WXChooseLocationRes

@synthesize address = _address;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize name = _name;

@end


@implementation WXGetLocationRes

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize speed = _speed;
@synthesize accuracy = _accuracy;
@synthesize altitude = _altitude;
@synthesize verticalAccuracy = _verticalAccuracy;
@synthesize horizontalAccuracy = _horizontalAccuracy;

@end


@implementation WX (WXLocation)

-(void) chooseLocation:(id<WXChooseLocationObject>) object {

}

-(void) getLocation:(id<WXGetLocationObject>) object {
    
}

@end


