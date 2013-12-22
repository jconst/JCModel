//
//  NSDictionary+CustomKVC.h
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CustomKVC)

- (id)jc_valueForKeyPath:(NSString *)keyPath;

///Adds support for * wildcard to valueForKey
- (id)jc_valueForKey:(NSString *)key;

@end
