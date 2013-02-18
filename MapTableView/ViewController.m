//
//  ViewController.m
//  MapTableView
//
//  Created by Jens Andersson on 2/18/13.
//  Copyright (c) 2013 Jens Andersson. All rights reserved.
//

#import "ViewController.h"
#import "MapLocation.h"
@interface ViewController ()

@end

#define CELL_HEIGHT 300
#define boris_random(smallNumber, bigNumber) ((((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * (bigNumber - smallNumber)) + smallNumber) 

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D currentLocation;
    currentLocation.latitude = 59.339011;
    currentLocation.longitude= 18.05706;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 500, 500);
    [self.mapView setRegion:viewRegion animated:YES];
    

    self.locations = [[NSMutableArray alloc] init];
     MapLocation *annotation = [[MapLocation alloc] initWithName:@"Rabble HQ" address:@"Adress 1" coordinate:currentLocation];
    [self.locations addObject:annotation];
    
    currentLocation.latitude -= 0.001;
    currentLocation.longitude -= 0.002;
    annotation = [[MapLocation alloc] initWithName:@"Mc Donalds" address:@"Adress 2" coordinate:currentLocation];
    [self.locations addObject:annotation];
    
    currentLocation.latitude -= 0.005;
    currentLocation.longitude -= 0.003;
    annotation = [[MapLocation alloc] initWithName:@"Burgerking" address:@"Adress 3" coordinate:currentLocation];
    [self.locations addObject:annotation];
    
    currentLocation.latitude += 0.015;
    currentLocation.longitude -= 0.013;
    annotation = [[MapLocation alloc] initWithName:@"Subway" address:@"Adress 4" coordinate:currentLocation];
    [self.locations addObject:annotation];
    
    
    for (int i = 0; i < 5; i++) {
        currentLocation.latitude += boris_random(-0.02, 0.01);
        currentLocation.longitude -= boris_random(-0.02, 0.01);
        annotation = [[MapLocation alloc] initWithName:@"Random" address:@"Adress" coordinate:currentLocation];
        [self.locations addObject:annotation];
    }
    
    [self.mapView addAnnotations:self.locations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.locations count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MapLocation *ml = [self.locations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = ml.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self scrollToLocationAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    uint i = [self.locations indexOfObject:view.annotation];
    if (i != NSNotFound)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)scrollToLocationAtIndexPath:(NSIndexPath *)indexPath
{
    MapLocation *ml = [self.locations objectAtIndex:indexPath.row];
    [self.mapView setCenterCoordinate:ml.coordinate animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static NSIndexPath *old;
    CGPoint p = scrollView.contentOffset;
    p.y += CELL_HEIGHT/2;
    NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:p];
    if ([old isEqual:ip])
        return;
    [self scrollToLocationAtIndexPath:ip];
    old = ip;
}

@end
