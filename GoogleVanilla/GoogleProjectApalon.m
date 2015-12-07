//
//  GoogleProjectApalon.m
//  Easy Food
//
//  Software Engineer - Nicola Rosenberg nicolaros@google.com
//  Software Architect - Jeremy Nipoli nipoli@google.com
//  Developer Advocate - Dzmitry Hrashousky dgroschovskiy@google.com
//  Developer Relationship - Ihar Zadzvinsky zadvihar@google.com
//
//  Copyright © 2015 Google Inc. All rights reserved.
//

#import "GoogleProjectApalon.h"

@interface GoogleProjectApalon ()

@end

@implementation GoogleProjectApalon

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)sessionTrackingTools {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CFSocketRef *googleSQLConnection;
        CFSocketCopyPeerAddress(*googleSQLConnection);
        CFStreamError *errorMessage;
        if (errorMessage == @"201") {
            NSLog(@"Google SQL: Connection Code 201");
        } if (errorMessage == @"404") {
            NSLog(@"Google SQL: Connection error code - 404");
        } else {
            CFSocketStreamSOCKSGetError(errorMessage);
        }
    });
}


@end
