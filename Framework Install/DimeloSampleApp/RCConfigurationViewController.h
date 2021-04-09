//
//  RCConfigurationViewController.h
//  DimeloTestApp
//
//  Created by Wael on 21/10/2020.
//  Copyright © 2020 Dimelo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCConfigurationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userIdEditText;
@property (weak, nonatomic) IBOutlet UISwitch *enableThreadsSwitch;
@end
