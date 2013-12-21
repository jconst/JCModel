//
//  NSDictionary+CustomKVC.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSDictionary+CustomKVC.h"

@implementation NSDictionary (CustomKVC)

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
    if ([key isEqualToString:@"*"])
        return [self allValues];
    else
        return [self valueForKey:key];
}

@end
