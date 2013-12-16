//
//  JCModel.m
//
//  Created by Joseph Constantakis on 8/20/13.
//

#import "JCModel.h"
#import "JCPropertyMapper.h"
#import "NSObject+Properties.h"

@implementation JCModel

#pragma mark - JSON Parsing

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

- (NSString *)description
{
    NSMutableString *ret = [NSMutableString stringWithString:[super description]];
    
    for (NSString *prop in [[self class] propertyNames]) {
        [ret appendFormat:@"\n%@: %@", prop, [self valueForKey:prop]];
    }
    return ret;
}

@end
