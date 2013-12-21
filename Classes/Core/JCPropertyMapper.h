//
//  JCPropertyMapper.h
//  JCModel
//
//  Created by Joseph Constantakis on 10/25/13.
//  Copyright (c) 2013 Joseph Constantakis. All rights reserved.
//

/**
 'JCPropertyMapper' is a simple, lightweight class that maps an ALREADY PARSED json object,
 like an NSDictionary or an NSArray of dictionaries, to an arbitrary destination class
 using a mapping given by another dictionary or plist.
 */

#import <Foundation/Foundation.h>

#define kAttrDateFormat @"dateFormat"

@interface JCPropertyMapper : NSObject

- (void)mapJSON:(id)json toObject:(id)object usingMappingPlist:(NSString *)plistName;
- (void)mapJSON:(id)json toObject:(id)object usingMapping:(NSDictionary *)mapping;

@end
