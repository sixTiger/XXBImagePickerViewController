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
@property (nonatomic, strong) id                popDelegate;
/**
 *  展示组的相册tableViewController
 */
@property(nonatomic , strong)XXBPhotoGroupTabVC *photoTableVC;
/**
 *  图片库资源
 */
@property(nonatomic , strong)ALAssetsLibrary    *library ;
/**
 *  图片group
 */
@property(nonatomic , strong)NSMutableArray     *photoGroupArray;
@property(nonatomic , strong)NSArray            *oldSelectPhotoAlasetModle;
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
+ (instancetype)initWithSelectPhotoALAssets:(NSArray *)selectPhotoALAssets
{
    return [self initWithSelectPhotoALAssets:selectPhotoALAssets];
}
- (instancetype)initWithSelectPhotoALAssets:(NSArray *)selectPhotoALAssets
{
    _oldSelectPhotoAlasetModle = selectPhotoALAssets;
    return [self init];
}
- (instancetype)init
{
    if (self = [super initWithRootViewController:self.photoTableVC])
    {
        self.showAllPhoto = NO;
        self.photoCount = NSIntegerMax;
        [self setupImagePickerController];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.delegate = nil;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0])
    { // 是根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
    else
    {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
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
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
            self.photoTableVC.allowPhoto = NO;
        };
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
            if (result!=NULL)
            {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
                {
                    /**
                     *  取出对应的photoGroupModle模型
                     */
                    XXBPhotoGroupModle *photoGroupModle = [self.photoGroupArray firstObject];
                    XXBPhotoAlasetModle *photoAlaetModle = [[XXBPhotoAlasetModle alloc] init];
                    photoAlaetModle.photoAlaset = result;
                    if ([result.description isEqualToString:@"ALAsset - Type:Photo, URLs:assets-library://asset/asset.JPG?id=106E99A1-4F6A-45A2-B320-B0AD4A8E8473&ext=JPG"])
                    {
                        NSLog(@"+++++++++%@",result);
                    }
                    /**
                     *  判断是否选中
                     */
                    if ([self.oldSelectPhotoAlasetModle containsObject:photoAlaetModle])
                    {
                        photoAlaetModle.select = YES;
                        NSInteger index = [self.oldSelectPhotoAlasetModle indexOfObject:photoAlaetModle] + 1;
                        photoAlaetModle.index = index;
                        photoAlaetModle.showPage = index;
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(index -1) inSection:0];
                        photoAlaetModle.indexPath = indexPath;
                        [self.selectPhotoALAssets addObject:photoAlaetModle];
                    }
                    [photoGroupModle.photoALAssets addObject:photoAlaetModle];
                }
            }
        };
        /**
         *  获取对应的组
         */
        ALAssetsLibraryGroupsEnumerationResultsBlock libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
            ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
            [group setAssetsFilter:onlyPhotosFilter];
            if ([group numberOfAssets] > 0)
            {
                /**
                 *  有一个新的group的模型来存放相关的信息
                 */
                XXBPhotoGroupModle *groupModle = [[XXBPhotoGroupModle alloc] init];
                if (self.photoGroupArray.count > 0)
                {
                    [self.photoGroupArray insertObject:groupModle atIndex:0];
                }
                else
                {
                    [self.photoGroupArray addObject:groupModle];
                }
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
            }
            else
            {
                [self.photoTableVC.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
                if(self.showAllPhoto)
                {
                    [self.photoTableVC performSelectorOnMainThread:@selector(showAllPhotos) withObject:nil waitUntilDone:NO];
                }
            }
        };
        _library = [self defaultAssetsLibrary];
        [_library enumerateGroupsWithTypes:ALAssetsGroupAll
                                usingBlock:libraryGroupsEnumeration
                              failureBlock:failureblock];
}
#pragma - 一些逻辑处理
- (void)setShowPage:(BOOL)showPage
{
    _showPage = showPage;
    self.photoTableVC.showPage = _showPage;
}
- (void)setPhotoCount:(NSInteger)photoCount
{
    _photoCount = photoCount;
    self.photoTableVC.photoCount = _photoCount;
}
#pragma mark - 懒加载
- (void)setAllowFromPhotos:(BOOL)allowFromPhotos
{
    _allowFromPhotos = allowFromPhotos;
    self.photoTableVC.allowFromPhotos = _allowFromPhotos;
}
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
        _photoTableVC.allowFromPhotos = YES;
        _photoTableVC.selectPhotoALAssets = self.selectPhotoALAssets;
        _photoTableVC.photoGroupTabVCDelegate = self;
        _photoTableVC.photoGroupArray = self.photoGroupArray;
        _photoTableVC.showAllPhoto = self.showAllPhoto;
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
    _selectPhotoALAssets = selectPhotoALAssets;
}
- (NSMutableArray *)photoGroupArray
{
    if (_photoGroupArray == nil) {
        _photoGroupArray = [NSMutableArray array];
    }
    return _photoGroupArray;
}
- (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t onceToken;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&onceToken,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}
@end
