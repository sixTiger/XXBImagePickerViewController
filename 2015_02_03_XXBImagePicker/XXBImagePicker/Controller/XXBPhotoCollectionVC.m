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


@interface XXBPhotoCollectionVC ()
@property(nonatomic , weak)XXBImagePickerTabr *imagePickerTar;
@end

@implementation XXBPhotoCollectionVC

static NSString * const reuseIdentifier = @"photoCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupItems];
    [self setupCollectionView];
    [self setupImagePickerTar];
    [self.collectionView registerClass:[XXBPhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
- (void)setupItems
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectPhotos)];
}
- (void)setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
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
}
- (void)selectPhotos
{
    if ([self.photoCollectionDelegate respondsToSelector:@selector(photoCollectionVCDidselectPhotos:)])
    {
        [self.photoCollectionDelegate photoCollectionVCDidselectPhotos:self];
    }
}
- (void)setPhotoALAssets:(NSMutableArray *)photoALAssets
{
    _photoALAssets = photoALAssets;
    [self.collectionView reloadData];
}
#pragma mark - collectionView 的相关处理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoALAssets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XXBPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
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
        [self.selectPhotoALAssets addObject:photoAlasetModle];
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
