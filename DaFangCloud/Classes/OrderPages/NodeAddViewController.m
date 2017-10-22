//
//  NodeAddViewController.m
//  DaFangCloud
//
//  Created by 谢涛 on 2017/10/22.
//  Copyright © 2017年 谢涛. All rights reserved.
//

#import "NodeAddViewController.h"
#import "CSPlistTool.h"
#import "CSPlistModel.h"
#import "CSPlistItemModel.h"
#import "DXLaunchActivityDescTableViewCell.h"
#import "DXLaunchActivityTableViewCell.h"
#import "BaseTableFooterView.h"
#import "NodeModel.h"
#import "SubmitTableViewCell.h"

#define kDescMaxLength 50   //  需求描述最长
#define kCommandContentMaxLength 200    //  需求具体说明长度

@interface NodeAddViewController ()<UITableViewDelegate, UITableViewDataSource, descTextViewDelegate, DXLaunchActivityTableViewCellDelegate, SubmitTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NodeModel *nodeModel;

@end

@implementation NodeAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureNavgationItemTitle:@"添加节点"];
    WEAKSELF
    [self configureBackButtonWithAction:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    if (self.nodeModel == nil) {
        self.nodeModel = [[NodeModel alloc] init];
    }

    self.dataSourceArray = [CSPlistTool loadGroupPlistFile:@"NodeAdd.plist"];
    DLog(@"%ld",self.dataSourceArray.count);
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CSPlistModel *model = self.dataSourceArray[section];
    return model.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSPlistModel *model = self.dataSourceArray[indexPath.section];
    CSPlistItemModel *itemModel = model.itemArray[indexPath.row];
    NSString *moduleTitle = itemModel.itemTitle;
    BOOL isRequired = itemModel.isRequired;
    if ([moduleTitle isEqualToString:@"备注说明"]) {
        static NSString *descIdentify = @"descIdentify";
        DXLaunchActivityDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:descIdentify];
        if (!cell) {
            cell = [[DXLaunchActivityDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:descIdentify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.descTextView.placeholder = [GeneralUtils getPlaceTitleIsRequired:isRequired placeHolder:moduleTitle];
            cell.delegate = self;
        }
        cell.movingView = tableView;
        cell.descTextView.text = self.nodeModel.nodeContent;
        return cell;
    }else if ([moduleTitle isEqualToString:@"保存按钮"]) {
        static NSString *cellName = @"SubmitTableViewCell";
        SubmitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SubmitTableViewCell" owner:self options:nil] lastObject];
            cell.delegate = self;
        }
        return cell;
        
    } else {
        static NSString *cellName = @"DXLaunchActivityTableViewCell";
        DXLaunchActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DXLaunchActivityTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftLabel.text = [NSString stringWithFormat:@"%@:",moduleTitle];
        }
        
        cell.rightViewType = DXRightViewTypeNone;
        cell.isDashPattern = NO;
        cell.activityTextField.text = @"";
        cell.activityTextField.keyboardType = UIKeyboardTypeDefault;
        cell.activityTextField.inputView = nil;
        cell.activityTextField.userInteractionEnabled = YES;
        cell.launchDelegate = self;
        cell.movingView = tableView;
        cell.moduleTitle = moduleTitle;
        if ([moduleTitle isEqualToString:@"预计成交月"]) {
            cell.activityTextField.text = self.nodeModel.nodeDate;
        } else if ([moduleTitle isEqualToString:@"节点名称"]) {
            cell.activityTextField.text = self.nodeModel.nodeName;
        }
        
        //  设置右侧指示图标
        if ([moduleTitle isEqualToString:@"预计成交月"]) {
            cell.rightViewType = DXRightViewTypeArrow;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSPlistModel *model = self.dataSourceArray[indexPath.section];
    CSPlistItemModel *itemModel = model.itemArray[indexPath.row];
    NSString *moduleTitle = itemModel.itemTitle;
    CGFloat cellHeight = 44.0;
    if ([moduleTitle isEqualToString:@"备注说明"]) {
        cellHeight = 201.0;
    } else if ([moduleTitle isEqualToString:@"保存按钮"]) {
        cellHeight = 50.0f;
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - UITextField delegate
//  让用户先进行开始时间选择
- (void)textFieldBeginEdit:(DXLaunchActivityTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CSPlistModel *model = self.dataSourceArray[indexPath.section];
    CSPlistItemModel *itemModel = model.itemArray[indexPath.row];
    
    NSString *moduleTitle = itemModel.itemTitle;
    if ([moduleTitle isEqualToString:@"节点名称"]) {
        
        
    }else{
        DLog(@"tip:不做处理！！！！");
    }
}

- (void)textFieldEndEdit:(DXLaunchActivityTableViewCell *)cell {
    UITextField *textField = (UITextField *)[cell viewWithTag:100];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *moduleTitle;
    CSPlistModel *model = self.dataSourceArray[indexPath.section];
    CSPlistItemModel *itemModel = model.itemArray[indexPath.row];
    moduleTitle = itemModel.itemTitle;
    if (textField.text.length > 0) {
        //  设置model数据
        if ([moduleTitle isEqualToString:@"预计成交月"]) {
            self.nodeModel.nodeDate = textField.text;
        } else if ([moduleTitle isEqualToString:@"节点名称"]) {
            self.nodeModel.nodeName = textField.text;
        } else {
            DLog(@"error:错误");
        }
    }else{
        DLog(@"tip:textfield 暂无数据");
    }
}


#pragma mark - descTextViewDelegate
//  开始编辑
- (void)textViewBeginEdit:(DXCustomerTextView *)textView{}

//  文本超出范围
- (void)textLengthBeyound:(NSInteger)maxLength {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"能力描述最多%ld个字",(long)maxLength] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

//  编辑结束
- (void)textViewEndEdit:(DXCustomerTextView *)textView {
    if (textView.text.length > 0) {
        self.nodeModel.nodeContent = textView.text;
    }
}

//  检查文本是否填写
- (BOOL)isContentLengthZero:(NSString *)contentStr {
    return [self getContentStr:contentStr].length == 0;
}
//  获取文本信息
- (NSString *)getContentStr:(NSString *)content {
    return [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)submitBtnClick:(UIButton *)btn {
    [self.view endEditing:YES];
    
    if ([self isContentLengthZero:self.nodeModel.nodeDate]
        ||[self isContentLengthZero:self.nodeModel.nodeName]
        || [self isContentLengthZero:self.nodeModel.nodeContent]
        ) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您有未输入的内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    //上传所需要的参数
    DLog(@"日期：%@，名称：%@，内容：%@",self.nodeModel.nodeDate,self.nodeModel.nodeName,self.nodeModel.nodeContent);
    

}




@end
