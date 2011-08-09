//
//  Kurzovni_ListekViewController.h
//  Kurzovni Listek
//
//  Created by Pisa Jiri on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>


@interface Kurzovni_ListekViewController : UIViewController <RKRequestDelegate, UITableViewDataSource>
{
    UITableView *tableView;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
