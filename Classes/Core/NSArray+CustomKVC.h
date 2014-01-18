//
//  NSArray+CustomKVC.h
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CustomKVC)

///@return result of calling jc_valueForKey: on each element (if supported),
/// or valueForKey: if not.
- (id)jc_valueForKey:(NSString *)key;

@end
