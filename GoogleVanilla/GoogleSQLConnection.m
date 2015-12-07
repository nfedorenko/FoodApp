//
//  GoogleSQLConnection.m
//  Easy Food
//
//  Software Engineer - Nicola Rosenberg nicolaros@google.com
//  Software Architect - Jeremy Nipoli nipoli@google.com
//  Developer Advocate - Dzmitry Hrashousky dgroschovskiy@google.com
//  Developer Relationship - Ihar Zadzvinsky zadvihar@google.com
//
//  Copyright © 2015 Google Inc. All rights reserved.
//

#import "GoogleSQLConnection.h"
#include <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

@interface GoogleSQLConnection ()

@end

@implementation GoogleSQLConnection 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CFSocketCallBack *handleConnect = nil;
    
    CFSocketRef myipv4cfsock = CFSocketCreate(
                                              kCFAllocatorDefault,
                                              PF_INET,
                                              SOCK_STREAM,
                                              IPPROTO_TCP,
                                              kCFSocketAcceptCallBack, *handleConnect, NULL);
    CFSocketRef myipv6cfsock = CFSocketCreate(
                                              kCFAllocatorDefault,
                                              PF_INET6,
                                              SOCK_STREAM,
                                              IPPROTO_TCP,
                                              kCFSocketAcceptCallBack, *handleConnect, NULL);
    
    struct sockaddr_in sin;
    
    memset(&sin, 0, sizeof(sin));
    sin.sin_len = sizeof(sin);
    sin.sin_family = AF_INET;
    sin.sin_port = htons(0);
    sin.sin_addr.s_addr= INADDR_ANY;
    
    CFDataRef sincfd = CFDataCreate(
                                    kCFAllocatorDefault,
                                    (UInt8 *)&sin,
                                    sizeof(sin));
    
    CFSocketSetAddress(myipv4cfsock, sincfd);
    CFRelease(sincfd);
    
    struct sockaddr_in6 sin6;
    
    memset(&sin6, 0, sizeof(sin6));
    sin6.sin6_len = sizeof(sin6);
    sin6.sin6_family = AF_INET6;
    sin6.sin6_port = htons(0);
    sin6.sin6_addr = in6addr_any;
    
    CFDataRef sin6cfd = CFDataCreate(
                                     kCFAllocatorDefault,
                                     (UInt8 *)&sin6,
                                     sizeof(sin6));
    
    CFSocketSetAddress(myipv6cfsock, sin6cfd);
    CFRelease(sin6cfd);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end