//
//  ViewController.m
//  accordion
//
//  Created by John Grant on 2014-10-30.
//  Copyright (c) 2014 JG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) NSInteger activeSection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activeSection = 0;
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:self.layout];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"test"];
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for row: %@", indexPath);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                           forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.backgroundColor = [UIColor blueColor];
            break;
        case 1:
            cell.backgroundColor = [UIColor yellowColor];
            [self relayoutWithoutAnimation];
            break;
        case 2:
            cell.backgroundColor = [UIColor greenColor];
            break;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                          withReuseIdentifier:@"test"
                                                                                 forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            header.backgroundColor = [UIColor purpleColor];
            break;
        case 1:
            header.backgroundColor = [UIColor grayColor];
            break;
        case 2:
            header.backgroundColor = [UIColor orangeColor];
            break;
    }
    
    return header;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != self.activeSection) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 0.1);
    }
    
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 700);
}

-  (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 37);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        self.activeSection++;
    }
    else if (indexPath.section == 2){
        self.activeSection = 0;
    }
    
    [self relayout];
}

- (void)relayout
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.collectionView.contentOffset = CGPointZero;
                         [self.layout invalidateLayout];
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)relayoutWithoutAnimation
{
    [self.layout invalidateLayout];
}


@end
