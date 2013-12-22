//
//  JCPropertyMapper.m
//  JCModel
//
//  Created by Joseph Constantakis on 10/25/13.
//  Copyright (c) 2013 Joseph Constantakis. All rights reserved.
//

#import "JCPropertyMapper.h"
#import "NSObject+Properties.h"
#import "NSDictionary+CustomKVC.h"
#import "NSArray+CustomKVC.h"
#import "NSObject+CustomKVC.h"

@implementation JCPropertyMapper

- (void)mapJSON:(id)json toObject:(id)object usingMappingPlist:(NSString *)plistName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *plist = [[NSDictionary alloc] initWithContentsOfFile:path];
    [self mapJSON:json toObject:object usingMapping:plist];
}

- (void)mapJSON:(id)json toObject:(id)object usingMapping:(NSDictionary *)mapping
{
    for (NSString *remoteKey in mapping) {
        
        [self resolveDynamicAttributesInRemoteKey:remoteKey json:json object:object mapping:mapping];
            
        if ([remoteKey hasPrefix:@"@"] && ![remoteKey hasPrefix:@"@("]) //ignore meta-keys
            continue;
        
        NSString *localKey = mapping[remoteKey];
        
        [self mapRemoteKey:remoteKey inJSON:json toLocalKey:localKey inObject:object withMapping:mapping];
    }
}

- (void)resolveDynamicAttributesInRemoteKey:(NSString *)remoteKey json:(id)json object:(id)object mapping:(NSDictionary *)mapping
{
    //Use regex to check for dynamic nesting attributes in the style of
    //https://github.com/RestKit/RestKit/wiki/Object-mapping#handling-dynamic-nesting-attributes
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@\\(([\\w\\.]*)\\)"
                                                                           options:0
                                                                             error:nil];
    [regex enumerateMatchesInString:remoteKey
                            options:0
                              range:NSMakeRange(0, remoteKey.length)
     usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
         
         if (flags & NSMatchingInternalError)
             return;
         
         NSRange resultRange = result.range;
         NSRange capGroup1 = [result rangeAtIndex:1];
         
         //replace stock.@(tickers) with stock.*
         NSString *localKey = [remoteKey substringWithRange:capGroup1];
         NSString *remoteKeyPrefix = [remoteKey substringToIndex:resultRange.location];
         NSString *remoteSubKey = [NSString stringWithFormat:@"%@*", remoteKeyPrefix];
         
         [self mapRemoteKey:remoteSubKey inJSON:json toLocalKey:localKey inObject:object withMapping:mapping];
     }];
}

- (void)mapRemoteKey:(NSString *)remoteKey
              inJSON:(id)json
          toLocalKey:(NSString *)localKey
            inObject:(id)object
         withMapping:(NSDictionary *)mapping
{
    id value = [json jc_valueForKeyPath:remoteKey];
    
    if (!value) {
        NSLog(@"mapping error: json dictionary %@ has no value for key path %@", json, remoteKey);
        return;
    } else if (value == [NSNull null]) {
        value = nil;
    }
    
    if ([object hasPropertyNamed:localKey]) {
        
        Class destClass = [[object class] classOfPropertyNamed:localKey];
        NSDictionary *attributes = [self attributesForKey:remoteKey inMapping:mapping];
        id transformed = [self value:value transformedToClass:destClass withAttributes:attributes];
        [object setValue:transformed forKey:localKey];
    } else
        NSLog(@"mapping error: object %@ has no property named %@", object, localKey);
}

- (NSDictionary *)attributesForKey:(NSString *)remoteKey inMapping:(NSDictionary *)mapping
{
    NSString *prefix = [NSString stringWithFormat:@"@%@.", remoteKey];
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    
    for (NSString *key in mapping) {
        if ([key hasPrefix:prefix]) {
            NSInteger firstDotLocation = [key rangeOfString:@"."].location;
            NSString *attrKey = [key substringFromIndex:firstDotLocation+1];
            //e.g. ret[@"dateFormat"] = mapping[@"@created.dateFormat"]
            ret[attrKey] = mapping[key];
        }
    }
    
    return ret;
}

- (id)value:(id)value transformedToClass:(Class)destClass withAttributes:(NSDictionary *)attributes
{
    if ([[value class] isSubclassOfClass:destClass])
        return value;
    if (destClass == [NSString class])
        return [value description];
    if ([[value class] isSubclassOfClass:[NSString class]]) {
        if (destClass == [NSNumber class]) {
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            return [f numberFromString:value];
        } if (destClass == [NSDate class]) {
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            if (attributes[kAttrDateFormat])
                [f setDateFormat:attributes[kAttrDateFormat]];
            return [f dateFromString:value];
        }
    }
    if ([[value class] isSubclassOfClass:[NSArray class]]) {
        if (destClass == [NSSet class])
            return [NSSet setWithArray:value];
        if (destClass == [NSMutableSet class])
            return [NSMutableSet setWithArray:value];
        if (destClass == [NSOrderedSet class])
            return [NSOrderedSet orderedSetWithArray:value];
        if (destClass == [NSMutableOrderedSet class])
            return [NSMutableOrderedSet orderedSetWithArray:value];
    }
    NSLog(@"failed to transform value %@ to class %@", value, destClass);
    return value;
}


@end
