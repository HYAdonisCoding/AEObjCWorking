//
//  AEPageMenuController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/24.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEPageMenuController.h"

static const CGFloat kMenuItemWidth   = 140.0f;
static const CGFloat kMenuItemHeight  = 40.0f;
static const CGFloat kMenuItemMargin  = 10.0f;
static const CGFloat kSmartTabMargin  =  8.0f;
static const CGFloat kIndicatorHeight =  2.0f;

static const NSInteger kMenuItemBaseTag = 161122;

#define    kHackaHexColor    0x66cdaa

// http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
static UIColor *
AEColorWithHex(int hex)
{
  return [UIColor colorWithRed:((float)((hex & 0xff0000) >> 16)) / 255.0f
             green:((float)((hex & 0xff00)   >>  8)) / 255.0f
              blue:((float)( hex & 0xff)) / 255.0f
             alpha:1.0f];
}


@interface AEMenuItem ()
@property (nonatomic,strong) UILabel *    label;
@property (nonatomic,assign) CGRect    menuFrame;
@property (nonatomic,readwrite,getter=isSelected) BOOL    selected;
@property (nonatomic,readwrite) AEPageMenuControllerStyle    menuStyle;
-(instancetype)initWithLabel:(UILabel *)label style:(AEPageMenuControllerStyle)style;
-(CAShapeLayer *)borderLayer;
@end


@interface AEPageMenuController () <UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic,readwrite) AEPageMenuControllerStyle    menuStyle;
@property (nonatomic,strong,readwrite) NSArray *    titles;
@property (nonatomic,strong,readwrite) NSArray *    childControllers;
@property (nonatomic,strong,readwrite) NSArray *    menuColors;
@property (nonatomic,assign) CGFloat            topBarHeight;
@property (nonatomic,strong) UIScrollView *        scrollView;
@property (nonatomic,strong) CALayer *            menuSeparator;
@property (nonatomic,strong) UIView *            menuIndicator;
@property (nonatomic,strong) NSMutableArray *        menuItems;
@property (nonatomic,assign) CGFloat            itemMargin;
@property (nonatomic,strong) UIPageViewController *    pageViewController;
@property (nonatomic,assign) NSUInteger            currentIndex;
@end

@implementation AEPageMenuController

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers
             menuStyle:(AEPageMenuControllerStyle)menuStyle
            menuColors:(NSArray<UIColor *> *)menuColors
              topBarHeight:(CGFloat)topBarHeight
{
  self = [super init];
  if (self) {
       _menuStyle = menuStyle;
      _menuColors = menuColors;
    _topBarHeight = topBarHeight;
    _currentIndex = 0;

    switch (menuStyle) {
      case AEPageMenuControllerStylePlain:
    _itemMargin = kMenuItemMargin;
    break;
      case AEPageMenuControllerStyleHackaTab:
    _itemMargin = kMenuItemMargin * 0.4f;
    break;
      default:
      case AEPageMenuControllerStyleTab:
      case AEPageMenuControllerStyleSmartTab:
    _itemMargin = 0.0f;
    break;
    }

    _childControllers = [[NSArray alloc]
              initWithArray:controllers copyItems:NO];

    NSUInteger n = 1;
    NSMutableArray * titles = [NSMutableArray new];
    for (UIViewController * vc in _childControllers) {
      NSString * title = [vc valueForKey:@"title"];
      if (title.length > 0) {
    [titles addObject:title];
      }
      else {
    [titles addObject:[NSString stringWithFormat:@"Title%zd", n]];
      }
      n++;
    }
    _titles = [[NSArray alloc] initWithArray:titles copyItems:YES];
  }
  return self;
}

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers
             menuStyle:(AEPageMenuControllerStyle)menuStyle
              topBarHeight:(CGFloat)topBarHeight
{
  NSArray * menuColors = @[
    AEColorWithHex(0xff7f7f),
    AEColorWithHex(0xbf7fff),
    AEColorWithHex(0x7f7fff),
    AEColorWithHex(0x7fbfff),
    AEColorWithHex(0x7fff7f),
    AEColorWithHex(0xffbf7f)
  ];
  return [self initWithControllers:controllers
             menuStyle:menuStyle
            menuColors:menuColors
              topBarHeight:topBarHeight];
}

-(void)dealloc
{
}

-(void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)loadView
{
  [super loadView];

  CGFloat width = self.view.bounds.size.width-80;

  CGFloat x = 0.0f;
  CGFloat y = _topBarHeight;
  CGFloat w = width;
  CGFloat h = kMenuItemHeight + kIndicatorHeight;
  UIScrollView * scrollView;
  scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
  scrollView.backgroundColor = [UIColor clearColor];
  scrollView.delegate = self;
  scrollView.bounces = NO;
  scrollView.scrollsToTop = NO;
  scrollView.pagingEnabled = NO;
  scrollView.showsHorizontalScrollIndicator = NO;
  [self.view addSubview:scrollView];
  self.scrollView = scrollView;

  [self prepareForMenuItems];
  [self prepareForMenuSeparator];
  [self prepareForMenuIndicator];
}

-(void)viewDidLoad
{
  [super viewDidLoad];

  UIPageViewControllerTransitionStyle style =
#if    1
    UIPageViewControllerTransitionStyleScroll;
#else
    UIPageViewControllerTransitionStylePageCurl;
#endif
  UIPageViewController * pageViewController =
    [[UIPageViewController alloc]
      initWithTransitionStyle:style
      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
      options:nil];
  pageViewController.delegate = self;
  self.pageViewController = pageViewController;

  UIViewController * startingViewController = self.childControllers[0];
  NSArray * viewControllers = @[startingViewController];
  [pageViewController setViewControllers:viewControllers
              direction:UIPageViewControllerNavigationDirectionForward
              animated:NO
              completion:nil];

  pageViewController.dataSource = self;

  [self addChildViewController:pageViewController];
  [self.view addSubview:pageViewController.view];

  CGFloat  width = self.view.bounds.size.width;
  CGFloat height = self.view.bounds.size.height;

  CGFloat x = 0.0f;
  CGFloat y = _topBarHeight + self.scrollView.frame.size.height;
  CGFloat w = width;
  CGFloat h = height - y;
  pageViewController.view.frame = CGRectMake(x, y, w, h);

  [pageViewController didMoveToParentViewController:self];

  if ([_delegate respondsToSelector:@selector(pageMenuController:didPrepareMenuItems:)]) {
    [_delegate pageMenuController:self didPrepareMenuItems:self.menuItems];
  }
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

/*****************************************************************************/

#pragma mark - convenient method
-(UIColor *)menuColorAtIndex:(NSUInteger)index
{
  NSUInteger numberOfColors = self.menuColors.count;
  return self.menuColors[index % numberOfColors];
}

/*****************************************************************************/

#pragma mark - override setter
-(void)setCurrentIndex:(NSUInteger)currentIndex
{
  if ([_delegate respondsToSelector:@selector(pageMenuController:didMoveToViewController:atMenuIndex:)]) {
    [_delegate pageMenuController:self
      didMoveToViewController:self.childControllers[currentIndex]
              atMenuIndex:currentIndex];
  }

  // タブの形状を復元
  AEMenuItem * item = self.menuItems[_currentIndex];
  switch (_menuStyle) {
    case AEPageMenuControllerStyleTab: {
            item.titleColor = [self menuColorAtIndex:_currentIndex];
            item.backgroundColor = [UIColor clearColor];
        }
          break;
    case AEPageMenuControllerStyleHackaTab: {
    item.titleColor = AEColorWithHex(kHackaHexColor);
    item.backgroundColor = [UIColor clearColor];
    [item borderLayer].hidden = NO;
      }
      // FALL THORUGH
    case AEPageMenuControllerStyleSmartTab: {
    CGRect frame = item.menuFrame;
    frame.origin.y = kSmartTabMargin;
    frame.size.height = kMenuItemHeight - kSmartTabMargin;
    item.menuFrame = frame;
      }
      break;
    default:
      break;
  }
  item.selected = NO;

  [self moveIndicatorAtIndex:currentIndex];

  _currentIndex = currentIndex;
}

#pragma mark - private method
-(void)moveIndicatorAtIndex:(NSUInteger)index
{
  // まずはタブを移動させる
  [self willMoveIndicatorAtIndex:index];

  // そのあとタブの装飾をする
  CGFloat w = kMenuItemWidth + _itemMargin;
  CGFloat x = w * index;

  UIColor * menuColor = [self menuColorAtIndex:index];

  AEMenuItem * item = self.menuItems[index];
  switch (_menuStyle) {
    default:
    case AEPageMenuControllerStylePlain: {
    CGRect frame = self.menuIndicator.frame;
    frame.origin.x = x;
    self.menuIndicator.frame = frame;
      }
      break;
    case AEPageMenuControllerStyleTab: {
        item.titleColor = [UIColor whiteColor];
        item.backgroundColor = menuColor;
        self.menuSeparator.backgroundColor = menuColor.CGColor;
        self.menuIndicator.backgroundColor = [UIColor clearColor];
      }
      break;
    case AEPageMenuControllerStyleSmartTab: {
        CGRect frame = item.menuFrame;
        frame.origin.y = 0.0f;
        frame.size.height = kMenuItemHeight;
        item.menuFrame = frame;
        self.menuIndicator.backgroundColor = menuColor;
      }
      break;
    case AEPageMenuControllerStyleHackaTab: {
    item.titleColor = [UIColor whiteColor];
    item.backgroundColor = AEColorWithHex(kHackaHexColor);
    CGRect frame = item.menuFrame;
    frame.origin.y = 0.0f;
    frame.size.height = kMenuItemHeight;
    item.menuFrame = frame;
    [item borderLayer].hidden = YES;
    self.menuIndicator.backgroundColor = [UIColor clearColor];
      }
      break;
  }
  item.selected = YES;

  if ([_delegate respondsToSelector:@selector(pageMenuController:didSelectMenuItem:atMenuIndex:)]) {
    [_delegate pageMenuController:self
        didSelectMenuItem:item atMenuIndex:index];
  }
}

#pragma mark - private method
-(void)willMoveIndicatorAtIndex:(NSUInteger)index
{
  CGFloat w = kMenuItemWidth + _itemMargin;
  CGFloat x = w * index;
  CGFloat y = 0.0f;

  CGFloat  width = self.scrollView.frame.size.width;
  // 選択したタブを中央寄せにする計算
  CGSize    size = self.scrollView.contentSize;
  CGFloat  leftX = (width - w) * 0.5f; // 画面幅の半分からタブ幅の半分を引く
  CGFloat   tabN = ceilf(width / w); // 画面内に見えるタブの数
  CGFloat rightX = size.width - floorf((tabN * 0.5f + 0.5f) * w);
       if (x <  leftX) { x  = 0.0f; }
  else if (x > rightX) { x  = size.width - width; }
  else               { x -= leftX; }
  [self.scrollView setContentOffset:CGPointMake(x, y) animated:YES];
}

/*****************************************************************************/

#pragma mark - private method
-(void)prepareForMenuItems
{
  self.menuItems = [NSMutableArray new];

  CGFloat x = 20.0f;
  CGFloat y = _menuStyle == AEPageMenuControllerStyleSmartTab ||
          _menuStyle == AEPageMenuControllerStyleHackaTab
        ? kSmartTabMargin
        : 0.0f;
  CGFloat w = kMenuItemWidth;
  CGFloat h = kMenuItemHeight - y;

  NSUInteger  tc = self.titles.count;
  for (NSUInteger i = 0; i < tc; i++) {
    UIColor * menuColor = [self menuColorAtIndex:i];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.tag = kMenuItemBaseTag + i;
    label.text = self.titles[i];
    label.textAlignment = NSTextAlignmentCenter;
    switch (_menuStyle) {
      default:
      case AEPageMenuControllerStylePlain:
        label.textColor = [UIColor orangeColor];
        label.backgroundColor = [UIColor clearColor];
            break;
      case AEPageMenuControllerStyleTab:
            if (i == _currentIndex) {
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = menuColor;
                for (id layer  in label.layer.sublayers) {
                    if ([layer isKindOfClass:[CAShapeLayer class]]) {
                        ((CAShapeLayer*)layer).fillColor = menuColor.CGColor;
                    }
                }
            }
            else {
                  label.textColor = menuColor;
                  label.backgroundColor = [UIColor clearColor];
            }
        break;
      case AEPageMenuControllerStyleSmartTab:
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = menuColor;
        if (i == 0) { // XXX: 最初のタブは大きく表示
          CGRect frame = label.frame;
          frame.origin.y = 0.0f;
          frame.size.height = kMenuItemHeight;
          label.frame = frame;
        }
    break;
      case AEPageMenuControllerStyleHackaTab:
    menuColor = AEColorWithHex(kHackaHexColor);
    if (i == _currentIndex) {
      label.textColor = [UIColor whiteColor];
      label.backgroundColor = menuColor;
      CGRect frame = label.frame;
      frame.origin.y = 0.0f;
      frame.size.height = kMenuItemHeight;
      label.frame = frame;
    }
    else {
      label.textColor = menuColor;
      label.backgroundColor = [UIColor clearColor];
    }
    break;
    }
    label.userInteractionEnabled = YES;
    [self.scrollView addSubview:label];
    x += (w + _itemMargin);

    UITapGestureRecognizer * tapGesture;
    tapGesture = [[UITapGestureRecognizer alloc]
          initWithTarget:self
          action:@selector(handleSingleTap:)];
    [label addGestureRecognizer:tapGesture];

    AEMenuItem * item =
    [[AEMenuItem alloc] initWithLabel:label style:_menuStyle];
    item.selected = (i == 0);
    [self.menuItems addObject:item];
  }

  CGFloat  width = self.scrollView.bounds.size.width;
  CGFloat height = self.scrollView.bounds.size.height;
  self.scrollView.contentSize = CGSizeMake(x, height);

  CGRect frame = self.scrollView.frame;
  if (width > x) { // 項目が少ないのね
    frame.origin.x = floorf((width - x) * 0.5f);
    frame.size.width = x;
  }
  else {
    frame.origin.x = 0.0f;
    frame.size.width = width;
  }
  self.scrollView.frame = frame;
}

#pragma mark - UITapGestureRecognizer handler
-(void)handleSingleTap:(UITapGestureRecognizer *)gesture
{
  NSInteger index = [gesture view].tag - kMenuItemBaseTag;

  UIViewController * viewController = self.childControllers[index];
  NSArray * viewControllers = @[viewController];
  UIPageViewControllerNavigationDirection direction
    = (index > _currentIndex)
    ? UIPageViewControllerNavigationDirectionForward
    : UIPageViewControllerNavigationDirectionReverse;
  self.currentIndex = index;
  [self.pageViewController setViewControllers:viewControllers
               direction:direction
               animated:YES
               completion:nil];
}

#pragma mark - private method
-(void)prepareForMenuSeparator
{
  CGFloat  width = self.scrollView.contentSize.width;
  CGFloat height = self.scrollView.frame.size.height;

  CGFloat x = 0.0f;
  CGFloat y = height;
  CGFloat w = width;
  CGFloat h = 0.0f;

  CALayer * layer = [CALayer new];

  UIColor * menuColor = self.menuColors[0];

  switch (_menuStyle) {
    case AEPageMenuControllerStylePlain:
      h = 1.0f; menuColor = [UIColor orangeColor];
      break;
    case AEPageMenuControllerStyleTab:
      h = 2.0f;
      break;
    case AEPageMenuControllerStyleHackaTab:
      h = 2.0f; menuColor = AEColorWithHex(kHackaHexColor);
      break;
    case AEPageMenuControllerStyleSmartTab:
    default:
      break;
  }
  y = height - h;
  layer.frame = CGRectMake(x, y, w, h);
  layer.actions = @{ @"backgroundColor" : [NSNull null] };
  layer.backgroundColor = menuColor.CGColor;
  [self.scrollView.layer addSublayer:layer];
  self.menuSeparator = layer;
}

- (UIScrollView *)getTheScrollView {
    return self.scrollView;
}

#pragma mark - private method
-(void)prepareForMenuIndicator
{
  CGFloat x = 0.0f;
  CGFloat y = self.scrollView.frame.size.height - kIndicatorHeight;
  CGFloat h = kIndicatorHeight;
  CGFloat w = kMenuItemWidth;

  UIColor * menuColor = self.menuColors[0];
  switch (_menuStyle) {
    default:
    case AEPageMenuControllerStylePlain:
      menuColor = [UIColor orangeColor];
      break;
    case AEPageMenuControllerStyleTab:
    case AEPageMenuControllerStyleSmartTab:
      w = self.scrollView.contentSize.width;
      break;
    case AEPageMenuControllerStyleHackaTab:
      menuColor = AEColorWithHex(kHackaHexColor);
      break;
  }

  UIView * menuIndicator;
  menuIndicator = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
  menuIndicator.backgroundColor = menuColor;
  [self.scrollView addSubview:menuIndicator];
  self.menuIndicator = menuIndicator;
}

/*****************************************************************************/

#pragma mark - public method
-(void)setMenuSeparatorColor:(UIColor *)color
{
  if (color) {
    self.menuSeparator.backgroundColor = color.CGColor;
  }
}

#pragma mark - public method
-(void)setMenuIndicatorColor:(UIColor *)color
{
  if (color) {
    self.menuIndicator.backgroundColor = color;
  }
}

/*****************************************************************************/

#pragma mark - UIPageViewControllerDelegate (optional)
// Sent when a gesture-initiated transition begins.
-(void)pageViewController:(UIPageViewController *)pageViewController
    willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
  UIViewController * viewController = [pendingViewControllers lastObject];
  NSUInteger index = [self.childControllers indexOfObject:viewController];

  if (index != _currentIndex) {
    [self willMoveIndicatorAtIndex:index];
  }

  if ([_delegate respondsToSelector:@selector(pageMenuController:willMoveToViewController:atMenuIndex:)]) {
    [_delegate pageMenuController:self
     willMoveToViewController:viewController
              atMenuIndex:index];
  }
}

#pragma mark - UIPageViewControllerDelegate (optional)
/*
 * Sent when a gesture-initiated transition ends. The 'finished' parameter
 * indicates whether the animation finished, while the 'completed' parameter
 * indicates whether the transition completed or bailed out (if the user let
 * go early).
 */
-(void)pageViewController:(UIPageViewController *)pageViewController
       didFinishAnimating:(BOOL)finished
  previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
      transitionCompleted:(BOOL)completed
{
  NSUInteger index = [self.childControllers indexOfObject:[pageViewController.viewControllers lastObject]];
  if (completed) {
    self.currentIndex = index;
  }
  else {
    [self willMoveIndicatorAtIndex:index];
  }
}

#pragma mark - UIPageViewControllerDelegate (optional)
/*
 * Delegate may specify a different spine location for after the interface
 * orientation change. Only sent for transition style
 * 'UIPageViewControllerTransitionStylePageCurl'.
 * Delegate may set new view controllers or update double-sided state within
 * this method's implementation as well.
 */
-(UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)
orientation
{
  if (UIInterfaceOrientationIsPortrait(orientation) ||
      ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
    UIViewController * currentViewController = pageViewController.viewControllers[0];
    NSArray * viewControllers = @[currentViewController];
    [pageViewController setViewControllers:viewControllers
            direction:UIPageViewControllerNavigationDirectionForward
            animated:YES
            completion:nil];
    pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
  }

  return UIPageViewControllerSpineLocationNone;
}

/*****************************************************************************/

#pragma mark - UIPageViewControllerDataSource (required)
/*
 * In terms of navigation direction. For example,
 * for 'UIPageViewControllerNavigationOrientationHorizontal', view controllers
 * coming 'before' would be to the left of the argument view controller,
 * those coming 'after' would be to the right.
 * Return 'nil' to indicate that no more progress can be made in the given
 * direction.
 * For gesture-initiated transitions, the page view controller obtains view
 * controllers via these methods, so use of
 * setViewControllers:direction:animated:completion: is not required.
 */
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
  NSUInteger index = [self.childControllers indexOfObject:viewController];
  if ((index == 0) || (index == NSNotFound)) {
    return nil;
  }

  index--;
  return self.childControllers[index];
}

#pragma mark - UIPageViewControllerDataSource (required)
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
  NSUInteger index = [self.childControllers indexOfObject:viewController];
  if (index == NSNotFound) {
    return nil;
  }

  index++;
  if (index == [self.childControllers count]) {
    return nil;
  }
  return self.childControllers[index];
}

@end

/******************************************************************************
 *
 * AEMenuItem Class
 *
 *****************************************************************************/
static NSString * const    kBorderLayerKey = @"kBorderLayerKey";
static NSString * const    kBadgeLayerKey  = @"kBadgeLayerKey";

@implementation AEMenuItem

-(instancetype)initWithLabel:(UILabel *)label
               style:(AEPageMenuControllerStyle)style
{
  self = [super init];
  if (self) {
      self.label = label;
          _title = label.text;
        _tag = 0;
     _badgeValue = nil;
        _enabled = YES;
       _selected = NO;
     _titleColor = label.textColor;
    _backgroundColor = label.backgroundColor;
      _menuFrame = label.frame;

    switch (style) {
      case AEPageMenuControllerStylePlain:
    break;
      case AEPageMenuControllerStyleTab:
            [self roundingCornersAndObliqueAngleOfLabel:label];
    break;
      case AEPageMenuControllerStyleSmartTab:
    [self roundingCornersOfLabel:label];
    break;
      case AEPageMenuControllerStyleHackaTab:
    [self addBordersOfLabel:label];
    break;
    }
    _menuStyle = style;
  }
  return self;
}

#pragma mark - override setter
-(void)setTitle:(NSString *)title
{
  if (![_title isEqualToString:title]) {
    _title = title;

    self.label.text = title;
  }
}

#pragma mark - override setter
-(void)setTitleColor:(UIColor *)titleColor
{
  if (titleColor != nil) {
    _titleColor = titleColor;

    self.label.textColor = titleColor;
  }
}

#pragma mark - override setter
-(void)setBackgroundColor:(UIColor *)backgroundColor
{
  if (backgroundColor != nil) {
    _backgroundColor = backgroundColor;

    self.label.backgroundColor = backgroundColor;
  }
}

#pragma mark - override setter
-(void)setBorderColor:(UIColor *)borderColor
{
  if (_menuStyle == AEPageMenuControllerStyleHackaTab) {
    if (borderColor != nil) {

      [self borderLayer].strokeColor = borderColor.CGColor;
    }
  }
  _borderColor = borderColor;
}

#pragma mark - override setter
-(void)setEnabled:(BOOL)enabled
{
  _enabled = enabled;

  self.label.userInteractionEnabled = enabled;
  if (enabled) {
    self.label.alpha = 1.0f;
  }
  else {
    self.label.alpha = 0.5f;
  }
}

#pragma mark - override setter
-(void)setSelected:(BOOL)selected
{
  _selected = selected;

  CATextLayer * textLayer = [self.label.layer valueForKey:kBadgeLayerKey];
  if (textLayer) {
    textLayer.hidden = (_badgeValue == nil || selected);
  }
}

#pragma mark - override setter
-(void)setMenuFrame:(CGRect)menuFrame
{
  _menuFrame = menuFrame;

  self.label.frame = menuFrame;

  if (_menuStyle == AEPageMenuControllerStyleSmartTab) {
    [self roundingCornersOfLabel:self.label];
  }
}

#pragma mark - override setter
-(void)setBadgeValue:(NSString *)badgeValue
{
  _badgeValue = badgeValue;

  if (_menuStyle == AEPageMenuControllerStyleHackaTab) {
    CATextLayer * textLayer = [self.label.layer valueForKey:kBadgeLayerKey];
    if (!textLayer) {
      CGFloat w = 16.0f;
      CGFloat h = w;
      CGFloat x = self.label.frame.size.width - w - 4.0f;
      CGFloat y = -kSmartTabMargin;
      textLayer = [CATextLayer new];
      textLayer.frame = CGRectMake(x, y, w, h);
      textLayer.fontSize = 12.0f;
      textLayer.foregroundColor = [UIColor whiteColor].CGColor;
      textLayer.backgroundColor = [UIColor redColor].CGColor;
      textLayer.cornerRadius = w * 0.5f;
      textLayer.masksToBounds = YES;
      textLayer.alignmentMode = kCAAlignmentCenter;
      textLayer.contentsScale = [UIScreen mainScreen].scale;
      textLayer.actions = @{ @"hidden" : [NSNull null] };
      [self.label.layer addSublayer:textLayer];
      [self.label.layer setValue:textLayer forKey:kBadgeLayerKey];
    }
    textLayer.string = badgeValue;
    textLayer.hidden = (badgeValue == nil || _selected);
  }
}

#pragma mark - public method
-(CAShapeLayer *)borderLayer
{
  return [self.label.layer valueForKey:kBorderLayerKey];
}

#pragma mark - private method
// 左上と右上の角を丸める
-(void)roundingCornersOfLabel:(UILabel *)label
{
  @autoreleasepool {
    UIBezierPath * maskPath =
    [UIBezierPath bezierPathWithRoundedRect:label.bounds
              byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
              cornerRadii:CGSizeMake(5.0f, 5.0f) ];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.frame  = label.bounds;
    maskLayer.path   = maskPath.CGPath;
    label.layer.mask = maskLayer;
  }
}
// 上面圆角+斜角
-(void)roundingCornersAndObliqueAngleOfLabel:(UILabel *)label
{
    @autoreleasepool {
        // 获取 label 的边界
        CGRect bounds = label.bounds;

        // 创建一个新的 UIBezierPath，用于定义梯形的路径
        UIBezierPath *maskPath = [UIBezierPath bezierPath];

        // 定义梯形的顶部外扩量（从每个顶部角落外扩）
        CGFloat topExpansion = 10;//bounds.size.height*0.5;

        // 移动到左下角（外扩）
        [maskPath moveToPoint:CGPointMake(CGRectGetMinX(bounds) - topExpansion, CGRectGetMaxY(bounds))];
        
        // 添加一条线到左上角
        [maskPath addLineToPoint:CGPointMake(CGRectGetMinX(bounds), CGRectGetMinY(bounds))];
        
        // 添加一条线到右上角
        [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(bounds), CGRectGetMinY(bounds))];
        
        // 添加一条线到右下角（外扩）
        [maskPath addLineToPoint:CGPointMake(CGRectGetMaxX(bounds) + topExpansion, CGRectGetMaxY(bounds))];
        
        // 关闭路径
        [maskPath closePath];

//        // 创建 CAShapeLayer，并设置其路径
//        CAShapeLayer *maskLayer = [CAShapeLayer layer];
//        
//        // 设置 CAShapeLayer 的 frame 为包含所有扩展部分的区域
//        
//        maskLayer.frame = CGRectMake(CGRectGetMinX(bounds) - topExpansion, CGRectGetMinY(bounds), CGRectGetWidth(bounds) + 2 * topExpansion, CGRectGetHeight(bounds));
//        
//        // 设置 path
//        maskLayer.path = maskPath.CGPath;
//
//        // 将 CAShapeLayer 设置为 label 的遮罩
//        label.layer.mask = maskLayer;
        
        CAShapeLayer *debugLayer = [CAShapeLayer layer];
        debugLayer.frame = CGRectMake(CGRectGetMinX(bounds) - topExpansion, CGRectGetMinY(bounds), CGRectGetWidth(bounds) + 2 * topExpansion, CGRectGetHeight(bounds));
        debugLayer.path = maskPath.CGPath;
        debugLayer.fillColor = [UIColor clearColor].CGColor;
        [label.layer addSublayer:debugLayer];


    }


	

}

#pragma mark - private method
// 左端と上と右端のみ枠線を付ける
-(void)addBordersOfLabel:(UILabel *)label
{
  @autoreleasepool {
    CGFloat w = label.frame.size.width;
    CGFloat h = label.frame.size.height;
    CGFloat x = 0.0f;
    CGFloat y = h;
    UIBezierPath * bezierPath = [UIBezierPath new];
    [bezierPath moveToPoint:CGPointMake(x, y)];    y = 0.0f;
    [bezierPath addLineToPoint:CGPointMake(x, y)]; x = w;
    [bezierPath addLineToPoint:CGPointMake(x, y)]; y = h;
    [bezierPath addLineToPoint:CGPointMake(x, y)];
    CAShapeLayer * shapeLayer = [CAShapeLayer new];
    shapeLayer.frame = label.bounds;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = AEColorWithHex(kHackaHexColor).CGColor;
    shapeLayer.lineWidth = 1.0f;
    /*
     * XXX: Disable implicit animation for hidden of CAShapeLayer.
     * http://stackoverflow.com/questions/5833488/how-to-disable-calayer-implicit-animations
     */
    shapeLayer.actions = @{ @"hidden" : [NSNull null] };
    [label.layer addSublayer:shapeLayer];
    [label.layer setValue:shapeLayer forKey:kBorderLayerKey];
  }
}

@end
