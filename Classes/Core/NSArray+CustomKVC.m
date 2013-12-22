//
//  NSArray+CustomKVC.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSArray+CustomKVC.h"

@implementation NSArray (CustomKVC)

- (id)jc_valueForKeyPath:(NSString *)keyPath;
{
    NSString *key = keyPath;
    NSInteger dotIndex = [keyPath rangeOfString:@"."].location;
    
    if (dotIndex != NSNotFound) {
        key = [keyPath substringToIndex:dotIndex];
        keyPath = [keyPath substringFromIndex:dotIndex+1];
    }
    
    id value = [self jc_valueForKey:key];
    
    if (dotIndex == NSNotFound)
        return value;
    else
        return [value jc_valueForKeyPath:keyPath]; //recurse
}

- (id)jc_valueForKey:(NSString *)key
{
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
