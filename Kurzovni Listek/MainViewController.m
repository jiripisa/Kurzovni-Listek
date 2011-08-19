//
//  Kurzovni_ListekViewController.m
//  Kurzovni Listek
//
//  Created by Pisa Jiri on 8/2/11.
//  Copyright 2011 TopMonks AG. All rights reserved.
//

#import "MainViewController.h"
#import "TableOfExchanges.h"
#import <RestKit/RestKit.h>
#import "ERTableViewCell.h"
#import <RestKit/Support/RKParser.h>
#import <RestKit/Support/XML/LibXML/RKXMLParserLibXML.h>

@interface MainViewController ()
- (void) loadExchangeRates;
- (void) refresh;
- (NSString*) formatDouble:(double) value;
@end

@implementation MainViewController

@synthesize tableView;

RKXMLParserLibXML* xmlParser;
TableOfExchanges* tableOfExchanges;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) awakeFromNib
{
    xmlParser = [RKXMLParserLibXML new];
    [tableView setHidden:TRUE];
    [self loadExchangeRates];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void) loadExchangeRates
{
    RKClient* client = [RKClient clientWithBaseURL:@"http://rb.cz"];
//    RKClient* client = [RKClient clientWithBaseURL:@"http://127.0.0.1"];
    [client get:@"/views/components/rates/ratesXML.jsp" delegate:self];
//    [client get:@"/~jpisa/rest/currency_rates.xml" delegate:self];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {  
    tableOfExchanges = nil;
    if ([request isGET]) {  
        if ([response isOK]) {  
            NSDictionary* exchangeRates = [xmlParser objectFromString:[response bodyAsString] error: nil];
            tableOfExchanges = [TableOfExchanges loadExchangeRates:exchangeRates];
            [tableView setHidden:FALSE];
        }  
    }
    [self refresh];
    
}  

- (void) refresh {
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (nil != tableOfExchanges) {
        return [tableOfExchanges getCountOfCurrencies];
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"erCell"];
    ExchangeRate* er = [tableOfExchanges getExchangeRate:[indexPath indexAtPosition:1]];
    
    [cell.currencyLabel setText: er.currencyName];
    [cell.saleDevizaLabel setText:[self formatDouble:er.devizaSale]];
    [cell.saleValutaLabel setText:[self formatDouble:er.valutaSale]];
    [cell.purchaseDevizaLabel setText:[self formatDouble:er.devizaPurchase]];
    [cell.purchaseValutaLabel setText:[self formatDouble:er.valutaPurchase]];
    [cell.middleLabel setText:[self formatDouble:er.middle]];
    
    UIImage *image = [UIImage imageNamed: [er.currencyName stringByAppendingString: @".gif"]];
    [cell.flagView setImage: image];
    return cell;
}

- (NSString*) formatDouble:(double) value
{
    double dbl = round (value * 1000.0) / 1000.0;
    return [NSString stringWithFormat:@"%.3f", dbl];
}

@end
