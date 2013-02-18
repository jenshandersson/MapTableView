//
//  ViewController.h
//  MapTableView
//
//  Created by Jens Andersson on 2/18/13.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,
                                                UITableViewDelegate,
                                                MKMapViewDelegate,
                                                UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *locations;

@end
