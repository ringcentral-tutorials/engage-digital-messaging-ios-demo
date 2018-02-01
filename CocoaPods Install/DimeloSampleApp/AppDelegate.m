#import "AppDelegate.h"
#import "Dimelo/Dimelo.h"

@interface AppDelegate () <DimeloDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Dimelo* dimelo = [Dimelo sharedInstance];
    dimelo.delegate = self;
    
    //Authentify using build-in authentification
    NSString* secret = @"<ENTER YOUR API SECRET HERE>";
    [dimelo setApiSecret:secret];

    // Authentify the user if you have an internal user_id otherwise this
    // is random
    dimelo.userIdentifier = @"application-user-id";
    dimelo.userName = @"John Doe";

    // Indicated in which environment your app is build
    // to receive APNs
    dimelo.developmentAPNS = NO;
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Register the device token.
    [Dimelo sharedInstance].deviceToken = deviceToken;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if ([[Dimelo sharedInstance] consumeReceivedRemoteNotification:userInfo])
    {
        // Notification is consumed by Dimelo, do not do anything else with it.
        return;
    }

    // You app's handling of the notification.
    // ...
}

- (IBAction) openChat:(id)sender
{
    Dimelo* dimelo = [Dimelo sharedInstance];
    
    //Aspect is configured by DimeloConfig.plist but it could be configured programmatically
    
    //dimelo.title = NSLocalizedString(@"Support Chat", @"Sample App");
    
    // Choose a random color to customize appearance of the chat.
    //double hue = drand48();
    //double hue2 = (((int)(hue*360) + (int)(240*drand48()))%360)/360.0;
    //UIColor* color = [UIColor colorWithHue:hue saturation:0.6 brightness:0.8 alpha:1.0];
    
    // For more information about available customization options, consult Dimelo.h
    // or documentation in Dimelo-iOS/Reference/html/index.html.
    //dimelo.backgroundView.backgroundColor = [UIColor colorWithHue:hue2 saturation:0.01 brightness:1.0 alpha:1.0];
    //dimelo.tintColor = color;
    //dimelo.dateTextColor = color;
    //dimelo.loadMoreMessagesButtonTextColor = color;
    //dimelo.userMessageBackgroundColor = color;
    //dimelo.agentMessageBackgroundColor = [UIColor colorWithHue:hue2 saturation:0.05 brightness:0.93 alpha:1.0];

    // Use standard entry point to open the chat in the same way,
    // it is opened from push notification.
    [dimelo displayChatView];
}

- (void) closeChat:(id)_
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Dimelo API callbacks


// This method is called by Dimelo when chat should be displayed
// (e.g. when user tapped a push notification).
// It is also used when you call -[Dimelo displayChatView].
- (void) dimeloDisplayChatViewController:(Dimelo*)dimelo
{
    UIViewController* vc = [dimelo chatViewController];

    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeChat:)];

    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

// These methods allow you to display network activity without Dimelo
// making decisions for you or hijacking your status bar indicator.
- (void) dimeloDidBeginNetworkActivity:(Dimelo*)dimelo
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) dimeloDidEndNetworkActivity:(Dimelo*)dimelo
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
