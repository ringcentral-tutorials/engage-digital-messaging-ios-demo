//
//  RCUserIdentifierViewController.m
//  DimeloTestApp
//
//  Created by Wael on 21/10/2020.
//  Copyright © 2020 Dimelo. All rights reserved.
//

#import "RCUserIdentifierViewController.h"
#import "Dimelo/Dimelo.h"

@implementation RCUserIdentifierViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userIdEditText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"rc_user_id"];
}

- (IBAction)startAction:(id)sender {
    NSString *userId = [self.userIdEditText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (userId.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"rc_user_id"];
        Dimelo.sharedInstance.userIdentifier = userId;
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rc_user_id"];
        Dimelo.sharedInstance.userIdentifier = nil;
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
