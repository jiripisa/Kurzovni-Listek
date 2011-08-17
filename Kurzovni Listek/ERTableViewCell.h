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
    UILabel* saleValutaLabel;
    UILabel* saleDevizaLabel;
    UILabel* purchaseValutaLabel;
    UILabel* purchaseDevizaLabel;
    UILabel* middleLabel;
    UIImageView* flagView;
}

@property (nonatomic, strong) IBOutlet UILabel* currencyLabel;
@property (nonatomic, strong) IBOutlet UILabel* saleValutaLabel;
@property (nonatomic, strong) IBOutlet UILabel* saleDevizaLabel;
@property (nonatomic, strong) IBOutlet UILabel* purchaseValutaLabel;
@property (nonatomic, strong) IBOutlet UILabel* purchaseDevizaLabel;
@property (nonatomic, strong) IBOutlet UILabel* middleLabel;
@property (nonatomic, strong) IBOutlet UIImageView* flagView;

@end
