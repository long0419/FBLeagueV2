# YHExcelView
##类似于excel的View
![](https://github.com/ShenYahui/YHExcelView/blob/master/1.png)  
![](https://github.com/ShenYahui/YHExcelView/blob/master/2.png) 
![](https://github.com/ShenYahui/YHExcelView/blob/master/3.png)
![](https://github.com/ShenYahui/YHExcelView/blob/master/4.png)
![](https://github.com/ShenYahui/YHExcelView/blob/master/5.png)  
![](https://github.com/ShenYahui/YHExcelView/blob/master/6.png)
![image](https://github.com/ShenYahui/YHExcelView/blob/master/8.png) 
#使用方法 
##和使用tableView类似，初始化YHExcelView 并设置dataSource
```Objective-C
#import "ViewController.h"
#import "YHExcel.h"
#import "UIView+YHCategory.h"

@interface ViewController ()<YHExcelTitleViewDataSource,YHExcelViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet YHExcelTitleView *titleView;//表头
@property (weak, nonatomic) IBOutlet YHExcelView *excelView;//表内容
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *colWidthArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.excelView.showBorder = YES;
    self.excelView.borderWidth = 1;
//    self.excelView.borderColor = [UIColor blueColor];
    self.titleArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
    self.colWidthArray = @[@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(40.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(40.0)];
    self.excelView.tableViewFrame = CGRectMake(0, 0, 750, self.excelView.yh_height);//设置可横向滚动
    self.titleView.contentSize = CGSizeMake(750, 0);
//    self.titleArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九"];
//    self.colWidthArray = @[@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(35.0),@(40.0)];
    self.titleView.dataSource = self;
    self.excelView.dataSource = self;
    self.excelView.backgroundColor = [UIColor whiteColor];
    
    //表头 与 表内容 同时滚动
    [self.titleView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld  context:nil];
    [self.excelView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
#pragma mark - YHExcelTitleViewDataSource
- (NSInteger)excelTitleViewItemCount:(YHExcelTitleView *)titleView {
    return self.titleArray.count;
}

- (NSString *)excelTitleView:(YHExcelTitleView *)titleView titleNameAtIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (CGFloat)excelTitleView:(YHExcelTitleView *)titleView widthForItemAtIndex:(NSInteger)index
{
    return [self.colWidthArray[index] doubleValue] * ([UIScreen mainScreen].bounds.size.width/320);
}

#pragma mark - YHExcelViewDataSource
- (NSInteger)excelView:(YHExcelView *)excelView columnCountAtIndexPath:(NSIndexPath *)indexPath {
    return self.titleArray.count;
//    return ((indexPath.row) % 9 ) + 1;
}

- (CGFloat)excelView:(YHExcelView *)excelView widthForColumnAtIndex:(YHExcelViewIndexPath *)indexPath {
    return [self.colWidthArray[indexPath.col] doubleValue] * ([UIScreen mainScreen].bounds.size.width/320);
}

- (YHExcelViewColumn *)excelView:(YHExcelView *)excelView columnForRowAtIndexPath:(YHExcelViewIndexPath *)indexPath {
    YHExcelViewColumn *col = [excelView dequeueReusableColumnWithIdentifier:@"col"];
    if (col == nil) {
        col = [[YHExcelViewColumn alloc] initWithReuseIdentifier:@"col"];
        col.textLabel.font = [UIFont systemFontOfSize:10];
    }
    NSString *text = [NSString stringWithFormat:@"%@行%@列",@(indexPath.row),@(indexPath.col)];
    col.textLabel.text = text;
    return col;
}

- (NSInteger)numberOfSectionsInExcelView:(YHExcelView *)excelView {
    return 1;
}

- (NSInteger)excelView:(YHExcelView *)excelView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint old = [change[@"old"] CGPointValue];
    CGPoint new = [change[@"new"] CGPointValue];
    if (old.x == new.x) {
        return;
    }
    if (object == self.titleView) {
        self.excelView.scrollView.contentOffset = CGPointMake(new.x, 0);
    }else if(object == self.excelView.scrollView){
        self.titleView.contentOffset = CGPointMake(new.x, 0);
    }
}

- (void)dealloc {
    [self.titleView removeObserver:self forKeyPath:@"contentOffset"];
    [self.excelView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end

