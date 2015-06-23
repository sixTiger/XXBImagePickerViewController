//
//  XXBImagePickerController.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBImagePickerController.h"
#import "XXBPhotoGroupTabVC.h"
#import "XXBPhotoGroupModle.h"
#import "XXBPhotoAlasetModle.h"

@interface XXBImagePickerController ()<XXBPhotoGroupTabVCDelegate>
{
    NSMutableArray *_selectPhotoALAssets;
}
/**
 *  展示组的相册tableViewController
 */
@property(nonatomic , strong)XXBPhotoGroupTabVC *photoTableVC;
/**
 *  图片库资源
 */
@property(nonatomic , strong)ALAssetsLibrary*library ;
/**
 *  图片group
 */
@property(nonatomic , strong)NSMutableArray *photoGroupArray;
@end

@implementation XXBImagePickerController
+ (void)initialize
{  // 取出appearance对象
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    // 设置背景
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
    //返回箭头的颜色
    navBar.tintColor = [UIColor blackColor];
}
- (instancetype)init
{
    if (self = [super initWithRootViewController:self.photoTableVC])
    {
        [self setupImagePickerController];
    }
    return self;
}
#pragma mark - 代理方法的处理
- (void)photoGroupTabVCCancleSelect:(XXBPhotoGroupTabVC *)photoGroupTabVC
{
    if ([self.imagePickerDelegate respondsToSelector:@selector(imagePickerControllerCancleselect:)])
    {
        [self.imagePickerDelegate imagePickerControllerCancleselect:self];
    }
}
- (void)photoGroupTabVCDidSelectPhotos:(XXBPhotoGroupTabVC *)photoGroupTabVC
{
//    [self.moveCellArray sortUsingComparator:^NSComparisonResult(XXBMoveCell *moveCell1, XXBMoveCell *moveCell2) {
//        // 按照按钮的索引降序重新排列数组
//        return moveCell1.index > moveCell2.index;
//    }];
    switch (self.photoSortType)
    {
        case XXBPhotoSortTypeSelectOrder:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModle *photo1, XXBPhotoAlasetModle *photo2) {
                return photo1.index > photo2.index;
            }];
            break;
        }
        case XXBPhotoSortTypeSelectDesc:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModle *photo1, XXBPhotoAlasetModle *photo2) {
                return photo1.index < photo2.index;
            }];
            break;
        }
        case XXBPhotoSortTypeSystemOrder:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModle *photo1, XXBPhotoAlasetModle *photo2) {
                return photo1.indexPath.row > photo2.indexPath.row;
            }];
            break;
        }
        case XXBPhotoSortTypeSystemDesc:
        {
            [self.selectPhotoALAssets sortUsingComparator:^NSComparisonResult(XXBPhotoAlasetModle *photo1, XXBPhotoAlasetModle *photo2) {
                return photo1.indexPath.row < photo2.indexPath.row;
            }];
            break;
        }
        default:
            break;
    }
    if ([self.imagePickerDelegate respondsToSelector:@selector(imagePickerController:didselectPhotos:)])
    {
        [self.imagePickerDelegate imagePickerController:self didselectPhotos:[self.selectPhotoALAssets copy]];
    }
}
#pragma mark - 获取图片库的所有资源
/**
 *  初始化imagePickerController
 */
- (void)setupImagePickerController
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
            NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
            if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
                NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
            }else{
                NSLog(@"相册访问失败.");
            }
        };
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
            if (result!=NULL)
            {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
                {
                    /**
                     *  取出对应的photoGroupModle模型
                     */
                    XXBPhotoGroupModle *photoGroupModle = [weakSelf.photoGroupArray lastObject];
                    XXBPhotoAlasetModle *photoAlaetModle = [[XXBPhotoAlasetModle alloc] init];
                    photoAlaetModle.photoAlaset = result;
                    /**
                     *  判断是否选中
                     */
                    photoAlaetModle.select = [weakSelf.selectPhotoALAssets containsObject:photoAlaetModle];
                    [photoGroupModle.photoALAssets addObject:photoAlaetModle];
                }
            }
        };
        /**
         *  获取对应的组
         */
        ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
            if (group!=nil)
            {
                /**
                 *  有一个新的group的模型来存放相关的信息
                 */
                XXBPhotoGroupModle *groupModle = [[XXBPhotoGroupModle alloc] init];
                [weakSelf.photoGroupArray addObject:groupModle];
                /**
                 *  获取photoGroup的组名
                 */
                groupModle.photoGroupName = [group valueForProperty:ALAssetsGroupPropertyName];
                /**
                 *  获取缩略图
                 */
                groupModle.photoGroupIcon = [UIImage imageWithCGImage:[group posterImage]];
                /**
                 *  便利组
                 */
                [group enumerateAssetsUsingBlock:groupEnumerAtion];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.photoTableVC.photoGroupArray = weakSelf.photoGroupArray;
                });
            }
        };
        _library = [[ALAssetsLibrary alloc] init];
        [_library enumerateGroupsWithTypes:ALAssetsGroupAll
                                usingBlock:libraryGroupsEnumeration
                              failureBlock:failureblock];
    });
    
}
#pragma mark - 懒加载

- (void)setPhotoInRow:(NSInteger)photoInRow
{
    _photoInRow = photoInRow;
    self.photoTableVC.photoInRow = photoInRow;
}

- (XXBPhotoGroupTabVC *)photoTableVC
{
    if (_photoTableVC == nil)
    {
        _photoTableVC = [[XXBPhotoGroupTabVC alloc] init];
        _photoTableVC.selectPhotoALAssets = self.selectPhotoALAssets;
        _photoTableVC.photoGroupTabVCDelegate = self;
    }
    return _photoTableVC;
}
- (NSMutableArray *)selectPhotoALAssets
{
    if (_selectPhotoALAssets == nil) {
        _selectPhotoALAssets = [NSMutableArray array];
    }
    return _selectPhotoALAssets;
}
- (void)setSelectPhotoALAssets:(NSMutableArray *)selectPhotoALAssets
{
    _selectPhotoALAssets = [selectPhotoALAssets mutableCopy];
}
- (NSMutableArray *)photoGroupArray
{
    if (_photoGroupArray == nil) {
        _photoGroupArray = [NSMutableArray array];
    }
    return _photoGroupArray;
}
@end
