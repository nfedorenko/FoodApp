//
//  GoogleJSONConverter.m
//  Easy Food
//
//  Software Engineer - Nicola Rosenberg nicolaros@google.com
//  Software Architect - Jeremy Nipoli nipoli@google.com
//  Developer Advocate - Dzmitry Hrashousky dgroschovskiy@google.com
//  Developer Relationship - Ihar Zadzvinsky zadvihar@google.com
//
//  Copyright © 2015 Google Inc. All rights reserved.
//

#import "GoogleJSONConverter.h"

@interface GoogleJSONConverter ()

@end

@implementation GoogleJSONConverter

- (void)viewDidLoad {
    [super viewDidLoad];

    [self googleCloudPlatformJSON];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)googleCloudPlatformJSON {
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"json"];
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];    NSError *jsonError;
    id allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONWritingPrettyPrinted error:&jsonError];
    for (int i=0; i<[allKeys count]; i++) {
        NSDictionary *arrayResult = [allKeys objectAtIndex:i];
        NSLog(@"name=%@",[arrayResult objectForKey:@"GoogleSQL-EUROPE-TIER2-IRELAND"]);
        
    }
}

@end
