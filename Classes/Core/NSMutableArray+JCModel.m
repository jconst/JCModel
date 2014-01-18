//
//  NSMutableArray+JCModel.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/18/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "NSMutableArray+JCModel.h"
#import "JCModel.h"

@implementation NSMutableArray (JCModel)

- (void)jc_sortAscending:(BOOL)ascending
{
    if (self.count) {
        Class firstClass = [self[0] class];
        if ([firstClass isSubclassOfClass:[JCModel class]]) {
            NSString *sortKey = [firstClass sortKey];
            if (sortKey) {
                NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending];
                [self sortUsingDescriptors:@[sortDesc]];
            }
        }
    }
}

@end
