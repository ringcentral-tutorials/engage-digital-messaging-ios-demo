//
//  AppDelegate.m
//  Dimelo Sample App
//
//  Created by Oleg Andreev on 19.09.2014.
//  Copyright (c) 2014 Dimelo. All rights reserved.
//

#import "AppDelegate.h"
#import "Dimelo.h"

@interface AppDelegate () <DimeloDelegate>

@end

@implementation AppDelegate {
    Dimelo* _dimelo;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString* secret = @"<ENTER YOUR API SECRET HERE>";
    NSString* hostname = @"<ENTER YOUR DIMELO HOSTNAME HERE>";

    Dimelo* dimelo = [[Dimelo alloc] initWithApiSecret:secret hostname:hostname delegate:self];

    // When any of these properties are set, JWT is recomputed instantly.
    dimelo.userIdentifier = @"U-1000555777";
    dimelo.authenticationInfo = @{@"bankBranch": @"Test-1234" };

    dimelo.title = NSLocalizedString(@"Support Chat", @"Sample App");

    _dimelo = dimelo;

    NSLog(@"JWT: %@", dimelo.jwt);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [dimelo displayChatView];

    });

    return YES;
}

- (void) dimeloDisplayChatViewController:(Dimelo*)dimelo
{
    [self.window.rootViewController presentViewController:[_dimelo chatViewController] animated:YES completion:^{
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
