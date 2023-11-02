//
//  AEIntelligentSortingController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/12.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEIntelligentSortingController.h"
#import "AEConvenientTool.h"
#import "Goods.h"

@interface AEIntelligentSortingController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSMutableArray *sectionTitlesArray;

@property (nonatomic, copy) NSMutableArray *dataArray;

@property (nonatomic, copy) NSMutableArray *sectionArray;

@end

@implementation AEIntelligentSortingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *localArray = @[@"菜.小", @"菜.大", @"林雨", @"林宏伟", @"周董", @"周树人", @"周杰", @"阿华", @"阿梨", @"安冬", @"杨国栋", @"赵华", @"叶青", @"王晓敏", @"党国倾", @"吴晓慧", @"任年华", @"陈庚", @"付海波", @"迪拜", @"滴华", @"鹤庆", @"杰斯", @"杰斌", @"牛羊", @".sdf", @"  Alisa", @"Bush", @"(US)Tushy"];

    for (int i=0; i<localArray.count;i++) {
        Goods *model = [Goods new];
        model.goodsName = localArray[i];
        [self.dataArray addObject:model];
    }

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    if (self.canGroup) {
        //索引字体颜色
        tableView.sectionIndexColor = [UIColor magentaColor];
        //背景色
        tableView.sectionIndexBackgroundColor = [UIColor systemTealColor];
//        [self sort];//本地排序
        /// 排序
        NSArray *sectionArray, *sectionTitlesArray;
        [AEConvenientTool sortWithDataArray:self.dataArray sectionArray:&sectionArray sectionTitlesArray:&sectionTitlesArray propertyName:@"goodsName"];
        self.sectionTitlesArray = sectionTitlesArray.mutableCopy;
        self.sectionArray = sectionArray.mutableCopy;
        
        [tableView reloadData];
    } else {
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCompose) target:self action:@selector(showDetail:)];
    }
}

#pragma mark - 排序
- (void)sort {
    ///1.UILocalizedIndexedCollation进行初始化
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    //获取collation索引
    NSUInteger sectionNumber = [[collation sectionTitles] count];
    NSMutableArray *section = [[NSMutableArray alloc] init];
    //    循环索引，初始化空数组并加入到数据数组
    for (NSInteger index = 0; index < sectionNumber; index++) {
        [section addObject:[[NSMutableArray alloc] init]];
    }
    //1.遍历数组中的元素
    for (Goods *model in self.dataArray) {
        //2.获取name值的首字母在26个字母中所在的位置
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(goodsName)];
        //3.把model对象加到相对应的字母下的数组中去
        [section[sectionIndex] addObject:model];
    }
    
    //对每个section中的数组按照name属性进行检索排序（快速索引）
    for(NSInteger index=0; index<sectionNumber;index++){
        //1.获取每个section下的数组
        NSMutableArray *personArrayForSection = section[index];
        //2.对每个section下的数组进行字母排序
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(goodsName)];
        section[index] = sortedPersonArrayForSection;
    }
    
// 新建一个temp空的数组（目的是为了在调用enumerateObjectsUsingBlock函数的时候把空的数组添加到这个数组里，在将数据源空数组移除，或者在函数调用的时候进行判断，空的移除）
    NSMutableArray *temp = [NSMutableArray new];
    [section enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.count == 0) {
            [temp addObject:obj];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [section removeObjectsInArray:temp];
    self.sectionArray = section;
}

- (void)showDetail:(UIBarButtonItem *)sender {
    AEIntelligentSortingController *vc = [AEIntelligentSortingController new];
    vc.title = @"Group";
    vc.canGroup = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组,第%ld行", (long)indexPath.section,indexPath.row];
    Goods *model;
    if (self.canGroup) {
        model = self.sectionArray[indexPath.section][indexPath.row];
    } else {
        model = self.dataArray[indexPath.row];
    }
    cell.textLabel.text = model.goodsName;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.canGroup ? [self.sectionArray[section] count] : self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.canGroup ? self.sectionTitlesArray.count : 1;
}

// 按顺序显示tableview的HeaderInSection标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.canGroup ? [self.sectionTitlesArray objectAtIndex:section] : @"";

}

// 按顺序显示检索字母（不返回就不显示右边索引内容）
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.canGroup ? self.sectionTitlesArray : @[];

}

// 点击右边索引执行的代理方法，可以在这里设置显示手指滑动时候索引的标题（sectionIndexColor是设置字体颜色，sectionIndexBackgroundColor背景颜色）
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    self.titleLabel.hidden = NO;
//    self.titleLabel.text = title;
    NSString *key = [self.sectionTitlesArray objectAtIndex:index];
    for (UIView *view in tableView.subviews) {
        NSLog(@"_________%@",view);
        if ([view isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
        }
    }
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}


#pragma mark - Lazy Load
- (NSMutableArray *)sectionTitlesArray {
    if (!_sectionTitlesArray) {
        _sectionTitlesArray = [NSMutableArray new];
    }
    return _sectionTitlesArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray new];
    }
    return _sectionArray;
}

@end
