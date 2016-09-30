//
//  ASLayoutSpecSnapshotTestsHelper.m
//  AsyncDisplayKit
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//

#import "ASLayoutSpecSnapshotTestsHelper.h"

#import "ASDisplayNode.h"
#import "ASLayoutSpec.h"
#import "ASLayout.h"

@interface ASTestNode : ASDisplayNode
- (void)setLayoutSpecUnderTest:(ASLayoutSpec *)layoutSpecUnderTest sizeRange:(ASSizeRange)sizeRange;
@end

@implementation ASLayoutSpecSnapshotTestCase

- (void)setUp
{
  [super setUp];
  self.recordMode = NO;
}

- (void)testLayoutSpec:(ASLayoutSpec *)layoutSpec
             sizeRange:(ASSizeRange)sizeRange
              subnodes:(NSArray *)subnodes
            identifier:(NSString *)identifier
{
  ASTestNode *node = [[ASTestNode alloc] init];

  for (ASDisplayNode *subnode in subnodes) {
    [node addSubnode:subnode];
  }
  
  [node setLayoutSpecUnderTest:layoutSpec sizeRange:sizeRange];
  
  ASSnapshotVerifyNode(node, identifier);
}

@end

@implementation ASTestNode
{
  ASLayout *_layoutUnderTest;
}

- (instancetype)init
{
  if (self = [super init]) {
    self.layerBacked = YES;
  }
  return self;
}

- (void)setLayoutSpecUnderTest:(ASLayoutSpec *)layoutSpecUnderTest sizeRange:(ASSizeRange)sizeRange
{
  ASLayout *layout = [layoutSpecUnderTest measureWithSizeRange:sizeRange];
  layout.position = CGPointZero;
  layout = [ASLayout layoutWithLayoutableObject:self
                           constrainedSizeRange:sizeRange
                                           size:layout.size
                                     sublayouts:@[layout]];
  _layoutUnderTest = [layout filteredNodeLayoutTree];
  self.frame = CGRectMake(0, 0, _layoutUnderTest.size.width, _layoutUnderTest.size.height);
  [self measure:_layoutUnderTest.size];
}

- (ASLayout *)calculateLayoutThatFits:(ASSizeRange)constrainedSize
{
  return _layoutUnderTest;
}

@end

@implementation ASStaticSizeDisplayNode

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
  return _staticSize;
}

@end
