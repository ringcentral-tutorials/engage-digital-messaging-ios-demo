//
//  DimeloAppDelegate.h
//
//
//  Created by Oleg Andreev on 23.07.2014.
//  Copyright (c) 2014 Dimelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface DimeloTestAppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>
@property (strong, nonatomic) UIWindow *window;
@end
