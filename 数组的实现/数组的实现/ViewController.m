//
//  ViewController.m
//  数组的实现
//
//  Created by lizizhen on 2019/8/14.
//  Copyright © 2019 lizi' zhen. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

// 定义了一个复合数据类型，该数据类型的名字叫做struct Arr，该数据类型有三个成员，分别是pBase, len, cun, increment.

// 
struct Arr {
    int * pBase; // 存储的是数组第一个元素的地址
    int len; // 数组所能容纳的最大元素的个数
    int cnt; // 当前数组有效元素的个数
    int increment; // 自动增长因子
};


- (void)viewDidLoad {
    [super viewDidLoad];
    
    struct Arr arr;
    init_arr(&arr, 6);
    show_arr(&arr);
    append_arr(&arr, 1);
    append_arr(&arr, 2);
    append_arr(&arr, 3);
    show_arr(&arr);
    
    insert_arr(&arr, 3, 99);
    show_arr(&arr);
    
    int val;
    delete_arr(&arr, 1, &val);
    show_arr(&arr);
    
    inversion_arr(&arr);
    show_arr(&arr);
    
    sort_arr(&arr);
    show_arr(&arr);
}

void init_arr(struct Arr *pArr, int length) { // 初始化
    pArr->pBase = (int *)malloc(sizeof(int) * length);
    if (NULL == pArr->pBase) {
        printf("动态内存分配失败!\n");
        exit(-1); //终止整个程序
    } else {
        pArr->len = length;
        pArr->cnt = 0;
        pArr->increment = 0;
    }
    return;
}

bool append_arr(struct Arr *pArr, int val) { // 追加
    // 满时返回false
    if (is_full_arr(pArr)) {
        printf("数组已满\n");
        return false;
    }
    
    // 不满时追加
    pArr->pBase[pArr->cnt] = val;
    (pArr->cnt)++;
    return true;
}

// pos表示在第pos个元素之前插入val
bool insert_arr(struct Arr *pArr, int pos, int val) { // 插入
    
    if (is_full_arr(pArr)) {
        return false;
    }
    
    if (pos<1 || pos>pArr->cnt+1) {
        return false;
    }
    
    for (int i = (pArr->cnt-1); i>=pos-1; --i) {
        pArr->pBase[i+1] = pArr->pBase[i];
    }
    pArr->pBase[pos-1] = val;
    (pArr->cnt)++;
    return true;
}

bool delete_arr(struct Arr *pArr, int pos, int *pVal) { // 删除
    if (is_empty_arr(pArr)) return false;
    if (pos < 1 || pos > pArr->cnt) return false;
    
    *pVal = pArr->pBase[pos-1];
    for (int i = pos; i<pArr->cnt; ++i) {
        pArr->pBase[i-1] = pArr->pBase[i];
    }
    pArr->cnt--;
    return true;
}

int get() { // 获取
    return 0;
}

bool is_empty_arr(struct Arr *pArr) { // 判断是否为空
    if (pArr->cnt == 0) {
        return true;
    }
    return false;
}

bool is_full_arr(struct Arr *pArr) { // 判断是否满了
    if (pArr->len == pArr->cnt) {
        return true;
    }
    return false;
}

void sort_arr(struct Arr *pArr) { // 排序(升序)
    int i, j, t;
    
    for (i = 0; i<pArr->cnt; ++i) {
        for (j = i+1; j<pArr->cnt; ++j) {
            if (pArr->pBase[i]>pArr->pBase[j]) {
                t = pArr->pBase[i];
                pArr->pBase[i] = pArr->pBase[j];
                pArr->pBase[j] = t;
            }
        }
    }
    return;
}

void show_arr(struct Arr *pArr) { // 展示
    if (is_empty_arr(pArr)) {
        printf("数组为空！\n");
    } else {
        for (int i = 0; i<pArr->cnt; ++i) {
            printf("%d ", pArr->pBase[i]);
        }
        printf("\n");
    }
}

void inversion_arr(struct Arr *pArr) { // 倒置
    int i = 0;
    int j = pArr->cnt-1;
    int t;
    while (i<j) {
        t = pArr->pBase[i];
        pArr->pBase[i] = pArr->pBase[j];
        pArr->pBase[j] = t;
        ++i;
        --j;
    }
    return;
}

@end

