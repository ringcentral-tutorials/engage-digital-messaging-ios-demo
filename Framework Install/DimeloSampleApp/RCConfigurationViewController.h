//
//  RCConfigurationViewController.h
//  DimeloTestApp
//
//  Created by Wael on 21/10/2020.
//  Copyright © 2020 Dimelo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCConfigurationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userIdEditText;
@property (weak, nonatomic) IBOutlet UITextField *usernameEditText;
@property (weak, nonatomic) IBOutlet UITextField *companyEditText;
@property (weak, nonatomic) IBOutlet UITextField *emailEditText;
@property (weak, nonatomic) IBOutlet UITextField *firstnameEditText;
@property (weak, nonatomic) IBOutlet UITextField *lastnameEditText;
@property (weak, nonatomic) IBOutlet UITextField *homePhoneEditText;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneEditText;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homePhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobilePhoneLabel;
@property (weak, nonatomic) IBOutlet UISwitch *enableThreadsSwitch;
@property (weak, nonatomic) IBOutlet UITableView *tableViewSources;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end
