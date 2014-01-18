//
//  JCModel.m
//
//  Created by Joseph Constantakis on 8/20/13.
//

#import "JCModel.h"
#import "JCPropertyMapper.h"
#import "NSMutableArray+JCModel.h"
#import "NSObject+Properties.h"
#import "NSBundle+PList.h"

@implementation JCModel

#pragma mark - JSON Parsing

+ (NSArray *)sortedArrayFromJSONArray:(NSArray *)array ascending:(BOOL)ascending
{
    NSMutableArray *ret = [[self arrayFromJSONArray:array] mutableCopy];
    [ret jc_sortAscending:ascending];
    return ret;
}

+ (NSArray *)arrayFromJSONArray:(NSArray *)array
{
    NSMutableArray *ret = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        JCModel *obj = [[self alloc] initFromDictionary:dict];
        [ret addObject:obj];
    }
    return ret;
}

- (id)initFromDictionary:(id)jsonObject
{
    self = [super init];
    if (self) {
        [self updateWithDictionary:jsonObject];
    }
    return self;
}

- (void)updateWithDictionary:(id)jsonObject
{
    [JCPropertyMapper mapDictionary:jsonObject toObject:self usingMapping:[[self class] remotePropertyMapping]];
}

+ (id)remotePropertyMapping
{
    NSString *plistName = [self mappingPlistName];
    
    return [[NSBundle mainBundle] plistNamed:plistName] ?: [self propertyNames];
}

+ (NSString *)mappingPlistName
{
    return [NSString stringWithFormat:@"%@Mapping", NSStringFromClass(self)];
}

#pragma mark - Equality

+ (NSArray *)equalityKeys
{
    return [self propertyNames];
}

- (NSUInteger)hash
{
    NSInteger ret = 0;
    
    for (NSString *key in [[self class] equalityKeys]) {
        ret ^= [[self valueForKey:key] hash];
    }
    return ret;
}

- (BOOL)isEqual:(id)other
{
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[JCModel class]])
        return NO;
    return [self isEqualToModelObject:other];
}

- (BOOL)isEqualToModelObject:(JCModel *)other
{
    if (self == other)
        return YES;
    
    NSSet *eqKeys = [NSSet setWithArray:[[self class] equalityKeys]];
    NSSet *theirKeys = [NSSet setWithArray:[[other class] equalityKeys]];
    
    if (![eqKeys isEqualToSet:theirKeys])
        return NO;
    
    for (NSString *key in eqKeys) {
        id myValue = [self valueForKey:key];
        id theirValue = [other valueForKey:key];
        if (![myValue isEqual:theirValue])
            return NO;
    }
    return YES;
}

#pragma mark - Helpers

+ (NSString *)sortKey
{
    //tries to guess a reasonable default sort key
    if ([self hasPropertyNamed:@"created"]) return @"created";
    if ([self hasPropertyNamed:@"createdDate"]) return @"createdDate";
    if ([self hasPropertyNamed:@"date"]) return @"date";
    if ([self hasPropertyNamed:@"name"]) return @"name";
    if ([self hasPropertyNamed:@"title"]) return @"title";
    NSArray *dateProps = [self namesForPropertiesOfClass:[NSDate class]];
    if (dateProps.count)
        return dateProps[0];
    if ([self hasPropertyNamed:@"id"]) return @"id";
    if ([self hasPropertyNamed:@"identifier"]) return @"identifier";
    return nil;
}

- (NSString *)description
{
    NSMutableString *ret = [NSMutableString stringWithString:[super description]];
    
    for (NSString *prop in [[self class] propertyNames]) {
        [ret appendFormat:@"\n%@: %@", prop, [self valueForKey:prop]];
    }
    return ret;
}

@end
