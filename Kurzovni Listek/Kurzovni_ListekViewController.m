//
//  Kurzovni_ListekViewController.m
//  Kurzovni Listek
//
//  Created by Pisa Jiri on 8/2/11.
//  Copyright 2011 TopMonks AG. All rights reserved.
//

#import "Kurzovni_ListekViewController.h"
#import <RestKit/RestKit.h>
#import "ERTableViewCell.h"
#import <RestKit/Support/RKParser.h>
#import <RestKit/Support/XML/LibXML/RKXMLParserLibXML.h>

@interface Kurzovni_ListekViewController ()
- (void) loadExchangeRates;
- (void) refresh;
- (NSString*) getCurrency:(NSInteger) index;
- (NSString*) getSaleValuta:(NSInteger) index;
- (NSString*) getPurchaseValuta:(NSInteger) index;
- (NSString*) getSaleDeviza:(NSInteger) index;
- (NSString*) getPurchaseDeviza:(NSInteger) index;
- (NSString*) getMiddle:(NSInteger) index;
@end

@implementation Kurzovni_ListekViewController

@synthesize tableView;

NSDictionary* exchangeRates;
RKXMLParserLibXML* xmlParser;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) awakeFromNib
{
    xmlParser = [RKXMLParserLibXML new];
    [self loadExchangeRates];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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
    exchangeRates = nil;
    if ([request isGET]) {  
        if ([response isOK]) {  
            exchangeRates = [xmlParser objectFromString:[response bodyAsString] error: nil];
        }  
    }
    [self refresh];
    
}  

- (void) refresh {
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (nil != exchangeRates) {
        int count = [[[[[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"] objectAtIndex:0]valueForKey:@"currency"] count] ;
        
        return count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"erCell"];
    [cell.currencyLabel setText:[self getCurrency:[indexPath indexAtPosition:1]]];
    [cell.saleDevizaLabel setText:[self getSaleDeviza:[indexPath indexAtPosition:1]]];
    [cell.saleValutaLabel setText:[self getSaleValuta:[indexPath indexAtPosition:1]]];
    [cell.purchaseDevizaLabel setText:[self getPurchaseDeviza:[indexPath indexAtPosition:1]]];
    [cell.purchaseValutaLabel setText:[self getPurchaseValuta:[indexPath indexAtPosition:1]]];
    [cell.middleLabel setText:[self getMiddle:[indexPath indexAtPosition:1]]];
    return cell;
}


- (NSString*) getCurrency:(NSInteger) index
{
    NSArray* _exchange_rates = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSDictionary* _first_er = [_exchange_rates objectAtIndex:0];
    NSString* name = [[_first_er valueForKey:@"name"] objectAtIndex:index];
    return name;
}

- (NSString*) getSaleValuta:(NSInteger) index
{
    NSArray* _exchange_rates = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSDictionary* _first_er = [_exchange_rates objectAtIndex:0];
    NSString* name = [[_first_er valueForKey:@"rate"] objectAtIndex:index];
    return name;
}

- (NSString*) getPurchaseValuta:(NSInteger) index
{
    NSArray* _exchange_rates = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSDictionary* _first_er = [_exchange_rates objectAtIndex:1];
    NSString* name = [[_first_er valueForKey:@"rate"] objectAtIndex:index];
    return name;
}

- (NSString*) getSaleDeviza:(NSInteger) index
{
    NSArray* _exchange_rates = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSDictionary* _first_er = [_exchange_rates objectAtIndex:2];
    NSString* name = [[_first_er valueForKey:@"rate"] objectAtIndex:index];
    return name;
}

- (NSString*) getPurchaseDeviza:(NSInteger) index
{
    NSArray* _exchange_rates = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSDictionary* _first_er = [_exchange_rates objectAtIndex:3];
    NSString* name = [[_first_er valueForKey:@"rate"] objectAtIndex:index];
    return name;
}

- (NSString*) getMiddle:(NSInteger) index
{
    NSArray* _exchange_rates = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSDictionary* _first_er = [_exchange_rates objectAtIndex:4];
    NSString* name = [[_first_er valueForKey:@"rate"] objectAtIndex:index];
    return name;
}

@end
