//
//  TableOfExchanges.m
//  Kurzovni Listek
//
//  Created by Jiri Pisa on 8/17/11.
//  Copyright (c) 2011 TopMonks AG. All rights reserved.
//

#import "TableOfExchanges.h"
#import "ExchangeRate.h"

@interface TableOfExchanges()

@property(nonatomic, retain) NSMutableArray* exchangeRates;

+ (NSDate*) dateFromString:(NSString*) strValue;
+ (double) rateFromDictionary:(NSDictionary*) dict atIndex:(int) index;

@end


@implementation TableOfExchanges

@synthesize validFrom;
@synthesize exchangeRates;

static NSDateFormatter* dateFormatter;

+(TableOfExchanges*) loadExchangeRates:(NSDictionary*)data
{
    TableOfExchanges* result = [TableOfExchanges new];
    //NSLog(@"%@", data);
    result.exchangeRates = [NSMutableArray new];
    
    NSArray* arrayExchangeRate = [[data valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSArray* arrayType = [[data valueForKey:@"exchange_rates"] valueForKey:@"type"];
    NSArray* arrayValidFrom = [[data valueForKey:@"exchange_rates"] valueForKey:@"valid_from"];
    
    result.validFrom = [TableOfExchanges dateFromString:[arrayValidFrom objectAtIndex:0]];
    
    int indexSaleValuta;
    int indexPurchaseValuta;
    int indexSaleDeviza;
    int indexPurchaseDeviza;
    int indexMiddle;
    
    
    for(int index = 0; index < 5; index++) {
        if ([[arrayType objectAtIndex:index] isEqualToString:@"XML_RATE_TYPE_EBNK_SALE_VALUTA"]) {
            indexSaleValuta = index;
        }
        if ([[arrayType objectAtIndex:index] isEqualToString:@"XML_RATE_TYPE_EBNK_PURCHASE_VALUTA"]) {
            indexPurchaseValuta = index;
        }
        if ([[arrayType objectAtIndex:index] isEqualToString:@"XML_RATE_TYPE_EBNK_SALE_DEVIZA"]) {
            indexSaleDeviza = index;
        }
        if ([[arrayType objectAtIndex:index] isEqualToString:@"XML_RATE_TYPE_EBNK_PURCHASE_DEVIZA"]) {
            indexPurchaseDeviza = index;
        }
        if ([[arrayType objectAtIndex:index] isEqualToString:@"XML_RATE_TYPE_EBNK_MIDDLE"]) {
            indexMiddle = index;
        }
    }
    
    NSDictionary* saleValutas = [arrayExchangeRate objectAtIndex:indexSaleValuta];
    NSDictionary* purchaseValutas = [arrayExchangeRate objectAtIndex:indexPurchaseValuta];
    NSDictionary* saleDevizas = [arrayExchangeRate objectAtIndex:indexSaleDeviza];
    NSDictionary* purchaseDevizas = [arrayExchangeRate objectAtIndex:indexPurchaseDeviza];
    NSDictionary* middles = [arrayExchangeRate objectAtIndex:indexMiddle];
    
    int countOfCurrencies = [[middles objectForKey:@"currency"] count];
    
    for(int index = 0; index < countOfCurrencies; index++) {
        ExchangeRate* exchangeRate = [ExchangeRate new];
        
        exchangeRate.valutaSale = [TableOfExchanges rateFromDictionary: saleValutas atIndex: index];
        exchangeRate.valutaPurchase = [TableOfExchanges rateFromDictionary: purchaseValutas atIndex: index];
        exchangeRate.devizaSale = [TableOfExchanges rateFromDictionary:saleDevizas atIndex:index];
        exchangeRate.devizaPurchase = [TableOfExchanges rateFromDictionary:purchaseDevizas atIndex:index];
        exchangeRate.middle = [TableOfExchanges rateFromDictionary: middles atIndex: index];
        exchangeRate.currencyName = [[middles objectForKey:@"name"] objectAtIndex:index];
        exchangeRate.quota = [[[middles objectForKey:@"quota"] objectAtIndex:index] intValue];
        
        [result.exchangeRates addObject:exchangeRate];
    }
    
    
    return result;
}

+(NSDate*) dateFromString:(NSString *)strValue
{
    if (dateFormatter == nil) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Europe/Prague"];
    }
    return [dateFormatter dateFromString:strValue];
}

+ (double) rateFromDictionary:(NSDictionary*) dict atIndex:(int) index 
{
    NSString* value = [[dict objectForKey:@"rate"] objectAtIndex:index];
    return [value doubleValue];
}

-(int) getCountOfCurrencies
{
    if (nil != exchangeRates) {
        return exchangeRates.count;
    } else {
        return 0;
    }
}

-(ExchangeRate*) getExchangeRate:(int) index
{
    return [self.exchangeRates objectAtIndex:index];
}

@end
