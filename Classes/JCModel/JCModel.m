//
//  JCModel.m
//
//  Created by Joseph Constantakis on 8/20/13.
//

#import "JCModel.h"
#import "JCPropertyMapper.h"
#import "NSMutableArray+JCModel.h"
#import <NSObject+Properties.h>

@implementation JCModel

#pragma mark - JSON Parsing

+ (NSArray *)sortedArrayFromJSONArray:(NSArray *)array ascending:(BOOL)ascending
{
    NSMutableArray *ret = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        JCModel *obj = [[self alloc] initFromDictionary:dict];
        [ret addObject:obj];
    }
    [ret jc_sortAscending:ascending];
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
    JCPropertyMapper *mapper = [[JCPropertyMapper alloc] init];
    
    [mapper mapJSON:jsonObject toObject:self usingMappingPlist:[self mappingPlistName]];
}

- (NSString *)mappingPlistName
{
    return [NSString stringWithFormat:@"%@Mapping", NSStringFromClass([self class])];
}

#pragma mark - Helpers

- (NSString *)description
{
    NSMutableString *ret = [NSMutableString stringWithString:[super description]];
    
    for (NSString *prop in [[self class] propertyNames]) {
        [ret appendFormat:@"\n%@: %@", prop, [self valueForKey:prop]];
    }
    return ret;
}

- (NSString *)sortKey
{
    //tries to guess a reasonable default sort key
    if ([self hasPropertyNamed:@"created"]) return @"created";
    if ([self hasPropertyNamed:@"name"]) return @"name";
    if ([self hasPropertyNamed:@"title"]) return @"title";
    if ([self hasPropertyNamed:@"date"]) return @"date";
    NSArray *dateProps = [self namesForPropertiesOfClass:[NSDate class]];
    if (dateProps.count)
        return dateProps[0];
    if ([self hasPropertyNamed:@"id"]) return @"id";
    if ([self hasPropertyNamed:@"identifier"]) return @"identifier";
    return nil;
}

@end
