//
//  NSDictionary+CustomKVC.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSDictionary+CustomKVC.h"

@implementation NSDictionary (CustomKVC)

- (id)jc_valueForKey:(NSString *)key
{
    if ([key isEqualToString:@"*"])
        return [self allValues];
    else if ([key isEqualToString:@"$"])
        return [self allKeys];
    else
        return [self valueForKey:key];
}

@end
