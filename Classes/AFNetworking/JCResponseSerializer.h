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
 'JCJSONResponseSerializer' is a response serializer for AFNetworking. Untested.
 */

@interface JCJSONResponseSerializer : AFJSONResponseSerializer

@end

@interface JCModel (JCJSONResponseSerializer)

+ (JCJSONResponseSerializer *)jc_jsonResponseSerializer;
+ (JCJSONResponseSerializer *)jc_jsonArrayResponseSerializer;

@end
