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
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadExchangeRates];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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


void describeDictionary (NSDictionary *dict)
{ 
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        //NSLog (@"Key: %@ for value: %@", key, value);
        NSLog (@"Key: %@", key);
    }
}

- (void) loadExchangeRates
{
//    RKClient* client = [RKClient clientWithBaseURL:@"http://62.168.6.14"];
//    RKClient* client = [RKClient clientWithBaseURL:@"http://rb.cz"];
    RKClient* client = [RKClient clientWithBaseURL:@"http://127.0.0.1"];
//    [client get:@"/views/components/rates/ratesXML.jsp?day=3&month=7&year=2011" delegate:self];
    [client get:@"/~jpisa/rest/currency_rates.xml" delegate:self];
}

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {  
    exchangeRates = nil;
    NSLog(@"Load Exchange Rates");
    if ([request isGET]) {  
        if ([response isOK]) {  
            //NSLog(@"%@", [response bodyAsString]);
            exchangeRates = [xmlParser objectFromString:[response bodyAsString] error: nil];
            NSLog(@"Object >> %@", [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"]);
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
        NSArray* erArray = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
        NSLog(@"Pocet: %i", [erArray count]);
        return [erArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"erCell"];
    [cell.currencyLabel setText:[self getCurrency:[indexPath indexAtPosition:1]]];
    return cell;
}


- (NSString*) getCurrency:(NSInteger) index
{
    NSArray* _exchange_rates = [[exchangeRates valueForKey:@"exchange_rates"] valueForKey:@"exchange_rate"];
    NSDictionary* _first_er = [_exchange_rates objectAtIndex:index];
    NSString* name = [_first_er valueForKey:@"name"];
    //describeDictionary(_first_er);
    NSLog(@"****** %i", index);
    return name;
}

@end
