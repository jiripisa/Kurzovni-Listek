//
//  ERTableViewCell.h
//  Kurzovni Listek
//
//  Created by Jiří Píša on 8/8/11.
//  Copyright (c) 2011 TopMonks AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ERTableViewCell : UITableViewCell {
 
    UILabel* currencyLabel;
}

@property (nonatomic, strong) IBOutlet UILabel* currencyLabel;

@end
