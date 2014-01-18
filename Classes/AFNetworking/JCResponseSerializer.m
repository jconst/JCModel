//
//  JCResponseSerializer.m
//  JCModel
//
//  Created by Joseph Constantakis on 12/10/13.
//  Copyright (c) 2013 Joseph Constantakis. All rights reserved.
//

#import "JCResponseSerializer.h"
#import "NSDictionary+CustomKVC.h"
#import "NSObject+CustomKVC.h"
#import "JCPropertyMapper.h"

NSString * const JCResponseSerializerErrorDomain = @"JCResponseSerializerErrorDomain";

@interface JCResponseSerializer ()

@property (readonly) Class responseObjectClass;
@property (readonly) BOOL inArray;
@property (readonly) NSString *rootKeyPath;

@end

@implementation JCResponseSerializer

- (instancetype)initWithResponseObjectClass:(Class)responseObjectClass
                                    inArray:(BOOL)inArray
                                rootKeyPath:(NSString *)rootKeyPath
{
    if (self = [super init]) {
        _responseObjectClass = responseObjectClass;
        _inArray = inArray;
        _rootKeyPath = rootKeyPath;
    }
    return self;
}

- (id)arrayResponseObjectForJSONObject:(id)object error:(NSError *__autoreleasing *)error
{
    if ([object isKindOfClass:[NSArray class]]) {
        return [self.responseObjectClass arrayFromJSONArray:object];
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
    if (self.rootKeyPath) {
        jsonDict = [jsonDict jc_valueForKeyPath:self.rootKeyPath];
    }

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

+ (JCResponseSerializer *)responseSerializer {
    return [[JCResponseSerializer alloc] initWithResponseObjectClass:self inArray:NO rootKeyPath:nil];
}

+ (JCResponseSerializer *)arrayResponseSerializer {
    return [[JCResponseSerializer alloc] initWithResponseObjectClass:self inArray:YES rootKeyPath:nil];
}

+ (JCResponseSerializer *)responseSerializerWithRootKeyPath:(NSString *)rootKeyPath {
    return [[JCResponseSerializer alloc] initWithResponseObjectClass:self inArray:NO rootKeyPath:rootKeyPath];
}

+ (JCResponseSerializer *)arrayResponseSerializerWithRootKeyPath:(NSString *)rootKeyPath {
    return [[JCResponseSerializer alloc] initWithResponseObjectClass:self inArray:YES rootKeyPath:rootKeyPath];
}

@end
