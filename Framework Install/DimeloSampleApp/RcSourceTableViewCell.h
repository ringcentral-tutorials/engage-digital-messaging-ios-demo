//
//  RcSourceTableViewCell.h
//  DimeloTestApp
//
//  Created by Wael on 27/09/2021.
//  Copyright © 2021 Dimelo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RcSourceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* descriptLabel;
@property (weak, nonatomic) IBOutlet UIImageView* selectImageView;
@property (weak, nonatomic) IBOutlet UIView* containerView;
@end
