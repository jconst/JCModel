//
//  BZModelObject.m
//  
//
//  Created by Joseph Constantakis on 8/20/13.
//
//

#import "JCModel.h"
#import "JCPropertyMapper.h"


@implementation JCModel

#pragma mark - JSON Parsing

- (id)initFromJSON:(id)jsonObject
{
    self = [super init];
    if (self) {
        [self updateWithJSON:jsonObject];
    }
    return self;
}

- (void)updateWithJSON:(id)jsonObject
{
    JCPropertyMapper *mapper = [[JCPropertyMapper alloc] init];
    mapper.defaultDateFormat = [self defaultDateFormat];
    
    [mapper mapJSON:jsonObject toObject:self usingMappingPlist:[self mappingPlistName]];
}

- (NSString *)defaultDateFormat
{
    return kDateFormat;
}

- (NSString *)mappingPlistName
{
    return [NSString stringWithFormat:@"%@Mapping", NSStringFromClass([self class])];
}

@end
