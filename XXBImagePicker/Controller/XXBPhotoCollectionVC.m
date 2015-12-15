//
//  XXBPhotoCollectionVC.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoCollectionVC.h"
#import "XXBPhotoCollectionViewCell.h"
#import "XXBPhotoAlasetModel.h"
#import "XXBImagePickerTabr.h"
#import "XXBCollectionFootView.h"

@interface XXBPhotoCollectionVC ()<XXBImagePickerTabrDelegate>

@property(nonatomic , weak)XXBImagePickerTabr *imagePickerTar;

@end

@implementation XXBPhotoCollectionVC

static NSString * const reuseCellIdentifier = @"photoCollectionViewCell";
static NSString * const reuseFooterIdentifier = @"photoCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupItems];
    [self setupCollectionView];
    [self setupImagePickerTar];
    [self.collectionView registerClass:[XXBPhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseCellIdentifier];
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:[XXBCollectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier];
}

- (void)setupItems
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancaleClick)];
}

- (void)setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    self.collectionView.alwaysBounceVertical = YES;
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *collectionViewRight = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionViewLeft = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *collectionViewBottom = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-44];
    NSLayoutConstraint *collectionViewTop = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraints:@[collectionViewLeft, collectionViewRight,collectionViewTop,collectionViewBottom]];
}

- (void)setupImagePickerTar
{
    XXBImagePickerTabr *imagePickerTar = [[XXBImagePickerTabr alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [self.view addSubview:imagePickerTar];
    imagePickerTar.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *imagePickerTarRight = [NSLayoutConstraint constraintWithItem:imagePickerTar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *imagePickerTarLeft = [NSLayoutConstraint constraintWithItem:imagePickerTar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *imagePickerTarBottom = [NSLayoutConstraint constraintWithItem:imagePickerTar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *imagePickerTarHeight = [NSLayoutConstraint constraintWithItem:imagePickerTar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    [self.view addConstraints:@[imagePickerTarLeft, imagePickerTarRight,imagePickerTarBottom,imagePickerTarHeight]];
    _imagePickerTar = imagePickerTar;
    imagePickerTar.delegate = self;
}

- (void)cancaleClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerTabrFinishClick
{
    if ([self.photoCollectionDelegate respondsToSelector:@selector(photoCollectionVCDidselectPhotos:)])
    {
        [self.photoCollectionDelegate photoCollectionVCDidselectPhotos:self];
    }
}

- (void)setShowPage:(BOOL)showPage
{
    _showPage = showPage;
    for (XXBPhotoAlasetModel  *photoAlasetModel in self.selectPhotoALAssets)
    {
        photoAlasetModel.showPage = _showPage;
    }
    if (self.selectPhotoALAssets.count > 0)
    {
        [self.collectionView reloadData];
    }
}

- (void)setPhotoALAssets:(NSMutableArray *)photoALAssets
{
    _photoALAssets = photoALAssets;
    [self.collectionView reloadData];
    self.imagePickerTar.selectCount = self.selectPhotoALAssets.count;
}

- (void)setSelectPhotoALAssets:(NSMutableArray *)selectPhotoALAssets
{
    _selectPhotoALAssets = selectPhotoALAssets;
    self.imagePickerTar.selectCount = _selectPhotoALAssets.count;
}

- (void)scrollToButtom
{
    if (self.photoALAssets.count == 0)
        return;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.photoALAssets.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

#pragma mark - collectionView 的相关处理
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    XXBCollectionFootView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        
    }
    if (kind == UICollectionElementKindSectionFooter)
    {
        
        reusableview = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
        reusableview.chooseMediaType = self.chooseMediaType;
        reusableview.number = self.photoALAssets.count;
    }
    return reusableview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoALAssets.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XXBPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.photoALAssets.count)
    {
        cell.photoAlasetModel = self.photoALAssets[indexPath.row];
    }
    else
    {
        cell.photoAlasetModel = nil;
        cell.chooseMediaType = self.chooseMediaType;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{        
        [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModel *photo1, XXBPhotoAlasetModel *photo2) {
            return photo1.index < photo2.index;
        }];
    });
    if (indexPath.row >= self.photoALAssets.count)
    {
        [self p_photoClick];
        return;
    }
    XXBPhotoAlasetModel *photoAlasetModel = self.photoALAssets[indexPath.row];
    photoAlasetModel.showPage = self.showPage;
    photoAlasetModel.select = !photoAlasetModel.select;
    photoAlasetModel.indexPath = indexPath;
    if(photoAlasetModel.select)
    {
        if(self.selectPhotoALAssets.count < self.photoCount)
        {
            [self.selectPhotoALAssets addObject:photoAlasetModel];
        }
        else
        {
            
            photoAlasetModel.select = !photoAlasetModel.select;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"你最多只能选择%@张照片",@(self.photoCount)] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alertView show];
        }
    }
    else
    {
        [self.selectPhotoALAssets removeObject:photoAlasetModel];
    }
    self.imagePickerTar.selectCount = self.selectPhotoALAssets.count;
    NSInteger count = self.selectPhotoALAssets.count;
    for (int i = 0;i < count ; i++)
    {
        XXBPhotoAlasetModel *photoAlasetModel = self.selectPhotoALAssets[i];
        photoAlasetModel.index = i + 1;
    }
    [collectionView reloadData];
}
- (void)p_photoClick
{
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
}
@end
