//
//  JCResponseSerializer.h
//  JCPropertyMapper
//
//  Created by Joseph Constantakis on 12/10/13.
//  Copyright (c) 2013 Jonah Grant. All rights reserved.
//

#import "AFURLResponseSerialization.h"
#import "ModelObject.h"

extern NSString * const LTCResponseSerializerErrorDomain;

@interface JCJSONResponseSerializer : AFJSONResponseSerializer

@end

@interface ModelObject (JCJSONResponseSerializer)

+ (JCJSONResponseSerializer *)jc_jsonResponseSerializer;
+ (JCJSONResponseSerializer *)jc_jsonArrayResponseSerializer;

@end
