//
//  Article.h
//  Benzinga
//
//  Created by Joseph Constantakis on 8/13/13.
//  Copyright (c) 2013 Benzinga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCModel.h"

@interface Article : JCModel

@property (strong, nonatomic) NSNumber * identifier;
@property (strong, nonatomic) NSString * authors;
@property (strong, nonatomic) NSString * body;
@property (strong, nonatomic) NSString * teaser;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSString * imageURL;
@property (strong, nonatomic) NSString * imageThumbURL;
@property (strong, nonatomic) NSDate * created;
@property (strong, nonatomic) NSDate * updated;

@property (strong, nonatomic) NSMutableSet *tickers;
@property (strong, nonatomic) NSMutableSet *channelIDs;

@end
