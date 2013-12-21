//
//  JCResponseSerializer.m
//  JCModel
//
//  Created by Joseph Constantakis on 12/10/13.
//  Copyright (c) 2013 Joseph Constantakis. All rights reserved.
//

#import "JCResponseSerializer.h"
#import "JCPropertyMapper.h"
#import "JCModel.h"

NSString * const JCResponseSerializerErrorDomain = @"JCResponseSerializerErrorDomain";

@interface JCJSONResponseSerializer ()

@property (readonly) Class responseObjectClass;
@property (readonly) BOOL inArray;

@end

@implementation JCJSONResponseSerializer

- (instancetype)initWithResponseObjectClass:(Class)responseObjectClass inArray:(BOOL)inArray
{
    if (self = [super init]) {
        _responseObjectClass = responseObjectClass;
        _inArray = inArray;
    }
    return self;
}

- (id)arrayResponseObjectForJSONObject:(id)object error:(NSError *__autoreleasing *)error
{
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *responseObjects = [NSMutableArray array];
        for (id element in object) {
            id responseObject = [self nonArrayResponseObjectForJSONObject:element
                                                                    error:error];
            if (responseObject) {
                [responseObjects addObject:responseObject];
            } else {
                return nil;
            }
        }
        return responseObjects;
    } else {
        if (error) {
            *error = [NSError errorWithDomain:JCResponseSerializerErrorDomain
                                         code:NSURLErrorBadServerResponse
                                     userInfo:nil];
        }
        return nil;
    }
}

- (id)nonArrayResponseObjectForJSONObject:(id)object error:(NSError *__autoreleasing *)error
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [[self.responseObjectClass alloc] initFromDictionary:object];
    } else {
        if (error) {
            *error = [NSError errorWithDomain:JCResponseSerializerErrorDomain
                                         code:NSURLErrorBadServerResponse
                                     userInfo:nil];
        }
        return nil;
    }
}

#pragma mark AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    NSDictionary *jsonDict = [super responseObjectForResponse:response
                                                         data:data
                                                        error:error];
    
    //TODO: Error checking
    
    if (self.inArray) {
        return [self arrayResponseObjectForJSONObject:jsonDict
                                                error:error];
    } else {
        return [self nonArrayResponseObjectForJSONObject:jsonDict
                                                   error:error];
    }
}

@end

@implementation JCModel (JCResponseSerializer)

+ (JCJSONResponseSerializer *)jc_jsonResponseSerializer {
    return [[JCJSONResponseSerializer alloc] initWithResponseObjectClass:self inArray:NO];
}

+ (JCJSONResponseSerializer *)jc_jsonArrayResponseSerializer {
    return [[JCJSONResponseSerializer alloc] initWithResponseObjectClass:self inArray:YES];
}

@end
