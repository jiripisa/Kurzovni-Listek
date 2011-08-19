//
//  Kurzovni_ListekTests.m
//  Kurzovni ListekTests
//
//  Created by Pisa Jiri on 8/2/11.
//  Copyright 2011 TopMonks AG. All rights reserved.
//

#import "Kurzovni_ListekTests.h"
#import "TableOfExchanges.h"
#import <RestKit/Support/XML/LibXML/RKXMLParserLibXML.h>

@implementation Kurzovni_ListekTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testLoadData
{
    NSBundle *unitTestBundle = [NSBundle bundleForClass:[self class]];
    NSString* xmlFileName = [unitTestBundle pathForResource:@"currency_rates.xml" ofType:nil];
    NSString* xmlData = [NSString stringWithContentsOfFile:xmlFileName encoding:NSUTF8StringEncoding error:nil];
    
    RKXMLParserLibXML* xmlParser = [RKXMLParserLibXML new];
    NSDictionary* result = [xmlParser objectFromString:xmlData error: nil];
    
    TableOfExchanges* tableOfExchanges = [TableOfExchanges loadExchangeRates:result];
    STAssertEquals(17, [tableOfExchanges getCountOfCurrencies], @"Getting count of currencies failed");
    
    ExchangeRate* er1 = [tableOfExchanges getExchangeRate:0];
    ExchangeRate* er2 = [tableOfExchanges getExchangeRate:1];
    ExchangeRate* er3 = [tableOfExchanges getExchangeRate:2];
    ExchangeRate* er4 = [tableOfExchanges getExchangeRate:3];
    ExchangeRate* er5 = [tableOfExchanges getExchangeRate:4];
    ExchangeRate* er6 = [tableOfExchanges getExchangeRate:5];
    ExchangeRate* er7 = [tableOfExchanges getExchangeRate:6];
    ExchangeRate* er8 = [tableOfExchanges getExchangeRate:7];
    ExchangeRate* er9 = [tableOfExchanges getExchangeRate:8];
    ExchangeRate* er10 = [tableOfExchanges getExchangeRate:9];
    ExchangeRate* er11 = [tableOfExchanges getExchangeRate:10];
    ExchangeRate* er12 = [tableOfExchanges getExchangeRate:11];
    ExchangeRate* er13 = [tableOfExchanges getExchangeRate:12];
    ExchangeRate* er14 = [tableOfExchanges getExchangeRate:13];
    ExchangeRate* er15 = [tableOfExchanges getExchangeRate:14];
    ExchangeRate* er16 = [tableOfExchanges getExchangeRate:15];
    ExchangeRate* er17 = [tableOfExchanges getExchangeRate:16];
        
    STAssertTrue([er1.currencyName isEqualToString: @"AUD"], @"Wrong currency name");
    STAssertEquals(18.8732, er1.valutaSale, @"Wrong value of sale valuta");
    STAssertEquals(17.5056, er1.valutaPurchase, @"Wrong value of purchase valuta");
    STAssertEquals(18.5541, er1.devizaSale, @"Wrong value of sale deviza");
    STAssertEquals(17.91589, er1.devizaPurchase, @"Wrong value of purchase deviza");
    STAssertEquals(18.235, er1.middle, @"Wrong value of middle");
    
    STAssertTrue([er2.currencyName isEqualToString: @"HRK"], @"Wrong currency name");
    STAssertTrue([er3.currencyName isEqualToString: @"DKK"], @"Wrong currency name");
    STAssertTrue([er4.currencyName isEqualToString: @"EUR"], @"Wrong currency name");
    STAssertTrue([er5.currencyName isEqualToString: @"JPY"], @"Wrong currency name");
    STAssertTrue([er6.currencyName isEqualToString: @"CAD"], @"Wrong currency name");
    STAssertTrue([er7.currencyName isEqualToString: @"HUF"], @"Wrong currency name");
    STAssertTrue([er8.currencyName isEqualToString: @"NOK"], @"Wrong currency name");
    STAssertTrue([er9.currencyName isEqualToString: @"NZD"], @"Wrong currency name");
    STAssertTrue([er10.currencyName isEqualToString: @"PLN"], @"Wrong currency name");
    STAssertTrue([er11.currencyName isEqualToString: @"RON"], @"Wrong currency name");
    STAssertTrue([er12.currencyName isEqualToString: @"RUB"], @"Wrong currency name");
    STAssertTrue([er13.currencyName isEqualToString: @"USD"], @"Wrong currency name");
    STAssertTrue([er14.currencyName isEqualToString: @"TRY"], @"Wrong currency name");
    STAssertTrue([er15.currencyName isEqualToString: @"GBP"], @"Wrong currency name");
    STAssertTrue([er16.currencyName isEqualToString: @"SEK"], @"Wrong currency name");
    STAssertTrue([er17.currencyName isEqualToString: @"CHF"], @"Wrong currency name");
}



@end
