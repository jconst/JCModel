//
//  JCModel.h
//
//  Created by Joseph Constantakis on 8/20/13.
//

/**
 'JCModel' is an optional base class for model objects, giving them 
 a few convenience methods for json mapping.
 */

#import <Foundation/Foundation.h>
#import "JCPropertyMapper.h"

@interface JCModel : NSObject <JCPropertyMappee>

+ (NSArray *)arrayFromJSONArray:(NSArray *)array;
+ (NSArray *)sortedArrayFromJSONArray:(NSArray *)array ascending:(BOOL)ascending;

- (id)initFromDictionary:(id)jsonObject;
- (void)updateWithDictionary:(id)jsonObject;

//Meant to be overridden:
+ (id)remotePropertyMapping;
+ (NSString *)mappingPlistName;
+ (NSString *)sortKey;
+ (NSArray *)equalityKeys;

@end
