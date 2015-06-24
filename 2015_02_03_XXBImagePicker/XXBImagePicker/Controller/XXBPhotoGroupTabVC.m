//
//  XXBPhotoGroupTabVC.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoGroupTabVC.h"
#import "XXBPhotoGroupModle.h"
#import "XXBPhotoGroupTVCell.h"
#import "XXBPhotoCollectionVC.h"
#import "XXBPhotoAlasetModle.h"

@interface XXBPhotoGroupTabVC ()<XXBPhotoCollectionVCDelegate>
{
    NSInteger _photoInRow;
}
@property(nonatomic , assign)BOOL firstShow;
@property(nonatomic , strong)XXBPhotoCollectionVC *photoCollectionVC;
@end

@implementation XXBPhotoGroupTabVC
- (instancetype)init
{
    if (self = [super init])
    {
        self.firstShow = YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"相机胶卷";
    self.tableView.rowHeight = 60;
    [self setupItems];
}
- (void)setupItems
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleSelectPhotos)];
}
#pragma mark - 相关的代理方法的处理
- (void)cancleSelectPhotos
{
    if ([self.photoGroupTabVCDelegate respondsToSelector:@selector(photoGroupTabVCCancleSelect:)])
    {
        [self.photoGroupTabVCDelegate photoGroupTabVCCancleSelect:self];
    }
}
- (void)photoCollectionVCDidselectPhotos:(XXBPhotoCollectionVC *)photoCollectionVC
{
    if ([self.photoGroupTabVCDelegate respondsToSelector:@selector(photoGroupTabVCDidSelectPhotos:)])
    {
        [self.photoGroupTabVCDelegate photoGroupTabVCDidSelectPhotos:self];
    }
}
- (void)setPhotoGroupArray:(NSMutableArray *)photoGroupArray
{
    _photoGroupArray = [photoGroupArray mutableCopy];
    [self.tableView reloadData];
    //默认跳转到相机胶卷选项里边
//    self.photoCollectionVC.photoALAssets = [self.photoGroupArray[0] photoALAssets];
}

#pragma mark - tableView相关方法的处理


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoGroupArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXBPhotoGroupTVCell *cell = [XXBPhotoGroupTVCell photoGroupTVCellWithTableView:tableView];
    XXBPhotoGroupModle *photoGroupModle = self.photoGroupArray[indexPath.row];
    cell.photoGroupModle = photoGroupModle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.photoCollectionVC.photoALAssets = [self.photoGroupArray[indexPath.row] photoALAssets];
    self.photoCollectionVC.title = [self.photoGroupArray[indexPath.row] photoGroupName];
    for (XXBPhotoAlasetModle *photoAlaset in self.selectPhotoALAssets)
    {
        photoAlaset.select = NO;
    }
    [self.selectPhotoALAssets removeAllObjects];
    [self.navigationController pushViewController:self.photoCollectionVC animated:YES];
}
#pragma mark - 
- (void)setShowPage:(BOOL)showPage
{
    _showPage = showPage;
    self.photoCollectionVC.showPage = _showPage;
}
#pragma mark - 懒加载
- (void)setPhotoInRow:(NSInteger)photoInRow
{
    _photoInRow = photoInRow;
    _photoCollectionVC = nil;
}

- (NSInteger)photoInRow
{
    if (_photoInRow == 0) {
        _photoInRow = 4;
    }
    return _photoInRow;
}

- (XXBPhotoCollectionVC *)photoCollectionVC
{
    if (_photoCollectionVC == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat screenWidth = MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        CGFloat itemWidth = (screenWidth - self.photoInRow -1)/(CGFloat)self.photoInRow;
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        
        _photoCollectionVC  = [[XXBPhotoCollectionVC alloc] initWithCollectionViewLayout:layout];
        _photoCollectionVC.selectPhotoALAssets = self.selectPhotoALAssets;
        _photoCollectionVC.photoCollectionDelegate = self;
    }
    return _photoCollectionVC;
}
@end
