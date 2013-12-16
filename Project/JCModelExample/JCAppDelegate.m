//
//  JCAppDelegate.m
//  JCModelExample
//
//  Created by Joseph Constantakis on 12/16/13.
//  Copyright (c) 2013 Joseph Constan. All rights reserved.
//

#import "JCAppDelegate.h"
#import "JCModel.h"
#import "Article.h"

@implementation JCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self tryMapping];
    
    return YES;
}

- (void)tryMapping
{
    NSString *json = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SampleArticle" ofType:@"json"]
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    NSError *parseError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:0 error:&parseError];
    NSLog(@"dict: %@, error: %@", dict, parseError);
    Article *article = [[Article alloc] initFromDictionary:dict];
    NSLog(@"article: %@", article);
}

@end
