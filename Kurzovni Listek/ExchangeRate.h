//
//  ExchangeRate.h
//  Kurzovni Listek
//
//  Created by Jiri Pisa on 8/17/11.
//  Copyright (c) 2011 TopMonks AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRate : NSObject {
    NSString* currencyName;
    int quota;
    double devizaSale;
    double devizaPurchase;
    double valutaSale;
    double valutaPurchase;
    double middle;
}

@property(atomic, copy) NSString* currencyName;
@property int quota;
@property double devizaSale;
@property double devizaPurchase;
@property double valutaSale;
@property double valutaPurchase;
@property double middle;

@end
