//
//  TableOfExchanges.h
//  Kurzovni Listek
//
//  Created by Jiri Pisa on 8/17/11.
//  Copyright (c) 2011 TopMonks AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeRate.h"

@interface TableOfExchanges : NSObject {
    NSDate* validFrom;
}

@property(atomic, copy) NSDate* validFrom;

+ (TableOfExchanges*) loadExchangeRates: NSDictionary;

- (int) getCountOfCurrencies;
- (ExchangeRate*) getExchangeRate:(int) index;

@end
