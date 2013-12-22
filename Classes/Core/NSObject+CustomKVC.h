//
//  NSObject+CustomKVC.h
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/21/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CustomKVC)

///Reimplementation of valueForKeyPath that calls jc_valueForKey instead of valueForKey
- (id)jc_valueForKeyPath:(NSString *)keyPath;

@end
