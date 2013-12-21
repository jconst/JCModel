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

@interface JCModel : NSObject

+ (NSArray *)arrayFromJSONArray:(NSArray *)array ascending:(BOOL)ascending;
+ (NSArray *)sortedArrayFromJSONArray:(NSArray *)array ascending:(BOOL)ascending;

- (id)initFromDictionary:(id)jsonObject;
- (void)updateWithDictionary:(id)jsonObject;
- (NSString *)sortKey;

@end
