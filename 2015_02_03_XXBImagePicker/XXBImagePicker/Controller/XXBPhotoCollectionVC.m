//
//  XXBPhotoCollectionVC.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoCollectionVC.h"
#import "XXBPhotoCollectionViewCell.h"
#import "XXBPhotoAlasetModle.h"
#import "XXBImagePickerTabr.h"
#import "UIView+AutoLayout.h"
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
    [self.collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 44, 0)];
    self.collectionView.alwaysBounceVertical = YES;
}
- (void)setupImagePickerTar
{
    XXBImagePickerTabr *imagePickerTar = [[XXBImagePickerTabr alloc] init];
    [self.view addSubview:imagePickerTar];
    [imagePickerTar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [imagePickerTar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.collectionView];
    _imagePickerTar = imagePickerTar;
    _imagePickerTar.delegate = self;
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
    for (XXBPhotoAlasetModle  *photoAlasetModle in self.selectPhotoALAssets)
    {
        photoAlasetModle.showPage = _showPage;
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
    self.imagePickerTar.selectCount = 0;
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
    
    if (kind == UICollectionElementKindSectionHeader){
        
    }
    
    if (kind == UICollectionElementKindSectionFooter){
        
        reusableview = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
        reusableview.numberString = [NSString stringWithFormat:@"%@",@(self.photoALAssets.count)];
    }
    return reusableview;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoALAssets.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XXBPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    cell.photoAlasetModle = self.photoALAssets[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XXBPhotoAlasetModle *photoAlasetModle = self.photoALAssets[indexPath.row];
    photoAlasetModle.showPage = self.showPage;
    photoAlasetModle.select = !photoAlasetModle.select;
    photoAlasetModle.indexPath = indexPath;
    if(photoAlasetModle.select)
    {
        if(self.selectPhotoALAssets.count < self.photoCount)
        {
            [self.selectPhotoALAssets addObject:photoAlasetModle];
        }
        else
        {
            
            photoAlasetModle.select = !photoAlasetModle.select;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"你最多只能选择%@张照片",@(self.photoCount)] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            [alertView show];
        }
    }
    else
    {
        [self.selectPhotoALAssets removeObject:photoAlasetModle];
    }
    self.imagePickerTar.selectCount = self.selectPhotoALAssets.count;
    NSInteger count = self.selectPhotoALAssets.count;
    for (int i = 0;i < count ; i++)
    {
        XXBPhotoAlasetModle *photoAlasetModle = self.selectPhotoALAssets[i];
        photoAlasetModle.index = i + 1;
    }
    [collectionView reloadData];
}
@end
