//
//  NSMutableOrderedSet+JCModel.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/18/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSMutableOrderedSet+JCModel.h"
#import "JCModel.h"

@implementation NSMutableOrderedSet (JCModel)

- (void)jc_sortAscending:(BOOL)ascending
{
    if (self.count) {
        id firstObject = self[0];
        if ([[firstObject class] isSubclassOfClass:[JCModel class]]) {
            NSString *sortKey = [firstObject sortKey];
            if (sortKey) {
                NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending];
                [self sortUsingDescriptors:@[sortDesc]];
            }
        }
    }
}

@end
