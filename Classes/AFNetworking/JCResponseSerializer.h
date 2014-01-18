//
//  JCResponseSerializer.h
//  JCModel
//
//  Created by Joseph Constantakis on 12/10/13.
//  Copyright (c) 2013 Jonah Grant. All rights reserved.
//

#import "AFURLResponseSerialization.h"
#import "JCModel.h"

/**
 'JCResponseSerializer' is a response serializer for AFNetworking.
 */

@interface JCResponseSerializer : AFJSONResponseSerializer

@end

@interface JCModel (JCResponseSerializer)

+ (JCResponseSerializer *)responseSerializer;
+ (JCResponseSerializer *)arrayResponseSerializer;
+ (JCResponseSerializer *)responseSerializerWithRootKeyPath:(NSString *)rootKeyPath;
+ (JCResponseSerializer *)arrayResponseSerializerWithRootKeyPath:(NSString *)rootKeyPath;

@end
