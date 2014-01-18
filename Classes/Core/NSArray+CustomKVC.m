//
//  NSArray+CustomKVC.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSArray+CustomKVC.h"

@implementation NSArray (CustomKVC)

- (id)jc_valueForKey:(NSString *)key
{
    NSScanner *scanner = [NSScanner scannerWithString:key];
    NSInteger intValue = 0;
    
    if ([scanner scanInteger:&intValue] && [scanner isAtEnd])
        return self[intValue];
    NSMutableArray *ret = [NSMutableArray array];
    for (id value in self) {
        if ([value respondsToSelector:@selector(jc_valueForKey:)])
            [ret addObject:[value jc_valueForKey:key]];
        else
            [ret addObject:[value valueForKey:key]];
    }
    return ret;
}

@end
