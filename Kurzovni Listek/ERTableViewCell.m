//
//  ERTableViewCell.m
//  Kurzovni Listek
//
//  Created by Jiří Píša on 8/8/11.
//  Copyright (c) 2011 TopMonks AG. All rights reserved.
//

#import "ERTableViewCell.h"

@implementation ERTableViewCell

@synthesize currencyLabel;
@synthesize saleValutaLabel;
@synthesize saleDevizaLabel;
@synthesize purchaseValutaLabel;
@synthesize purchaseDevizaLabel;
@synthesize middleLabel;
@synthesize flagView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
