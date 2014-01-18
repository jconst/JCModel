//
//  NSBundle+PList.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/24/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSBundle+PList.h"

@implementation NSBundle (PList)

- (id)plistNamed:(NSString *)plistName
{
    NSString *path = [self pathForResource:plistName ofType:@"plist"];
    
    NSDictionary *dMap = [[NSDictionary alloc] initWithContentsOfFile:path];
    if (dMap)
        return dMap;
    NSArray *aMap = [[NSArray alloc] initWithContentsOfFile:path];
    if (aMap)
        return aMap;
    return nil;
}

@end
