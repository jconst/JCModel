//
//  NSObject+CustomKVC.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSObject+CustomKVC.h"
#import "NSArray+CustomKVC.h"
#import "NSDictionary+CustomKVC.h"

@implementation NSObject (CustomKVC)

- (id)jc_valueForKeyPath:(NSString *)keyPath;
{
    NSString *key = keyPath;
    NSInteger dotIndex = [keyPath rangeOfString:@"."].location;
    
    if (dotIndex != NSNotFound) {
        key = [keyPath substringToIndex:dotIndex];
        keyPath = [keyPath substringFromIndex:dotIndex+1];
    }
    
    id value = ([self respondsToSelector:@selector(jc_valueForKey:)]) ? [(id)self jc_valueForKey:key] : [self valueForKey:key];
    
    if (dotIndex == NSNotFound)
        return value;
    else
        return [value jc_valueForKeyPath:keyPath]; //recurse
}

@end
