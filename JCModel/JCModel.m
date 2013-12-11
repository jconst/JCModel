//
//  JCModel.m
//
//  Created by Joseph Constantakis on 8/20/13.
//

#import "JCModel.h"
#import "JCPropertyMapper.h"


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
    mapper.defaultDateFormat = [self defaultDateFormat];
    
    [mapper mapJSON:jsonObject toObject:self usingMappingPlist:[self mappingPlistName]];
}

- (NSString *)defaultDateFormat
{
    return @"yyyy-MM-dd";
}

- (NSString *)mappingPlistName
{
    return [NSString stringWithFormat:@"%@Mapping", NSStringFromClass([self class])];
}

@end
