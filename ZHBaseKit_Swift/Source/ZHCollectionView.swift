//
//  ZHCollectionView.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

@objc public protocol ZHCollectionViewLayoutDelegate
{
   @objc optional func collectionViewLayout() -> UICollectionViewLayout;
}

open class ZHCollectionView: UICollectionView {

    public lazy var imp: ZHCollectionViewIMP = {
        let imp = ZHCollectionViewIMP();
        
        imp.collectionViewDidScrollClosure = { [weak self] scorllView in
            self?.collectionViewDidScrollClosure?(scorllView);
        }
        imp.collectionViewDidEndDeceleratingClosure = { [weak self] scorllView in
            self?.collectionViewDidEndDeceleratingClosure?(scorllView)
        }
        imp.collectionViewDidEndDraggingClosure = { [weak self] scorllView,decelerate in
            self?.collectionViewDidEndDraggingClosure?(scorllView,decelerate);
        }
        imp.collectionViewDidEndMovingClosure = { [weak self] (at,to) in
            self?.collectionViewDidEndMovingClosure?(at,to)
        }
        
        return imp;
    }()
    
    public var sections:[ZHCollectionViewSection] = [ZHCollectionViewSection]() {
        didSet
        {
            self.imp.sections = sections;
        }
    }
    

    //MARK: Closure
    public var collectionViewDidScrollClosure: ZHCollectionViewDidScrollClosure?
    public var collectionViewDidEndDeceleratingClosure: ZHCollectionViewDidEndDeceleratingClosure?
    public var collectionViewDidEndDraggingClosure: ZHCollectionViewDidEndDraggingClosure?
    public var collectionViewDidEndMovingClosure: ZHCollectionViewDidEndMovingClosure?
    
    //MARK: Allow move
    public var allowMoveItems   = false
    {
        didSet {
            
            if allowMoveItems == true {
                let longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGestureAction(_:)));
                longPressGesture.minimumPressDuration = 0.5;
                self.addGestureRecognizer(longPressGesture);
            }
        }
        
    }
    
    //MARK: Only move in the sections, default all
    public var onlyMoveSections = [Int]()
    //MARK: Only move in the same section
    public var onlyMoveInSameSection = true
    //MARK: the current move indexpath
    private var currentMoveIndexPath:IndexPath?
    
    open func onConfiguration()
    {
        self.backgroundColor = UIColor.clear;
        self.delegate   = self.imp;
        self.dataSource = self.imp;
        self.showsHorizontalScrollIndicator = false;
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never;
        }
    
    }
    
    
    public init(_ delegate : AnyObject?) {
    
        var flowLayout:UICollectionViewLayout?
        
        if delegate != nil
        {
            if delegate!.responds(to:#selector(ZHCollectionViewLayoutDelegate.collectionViewLayout))
            {
                flowLayout =  delegate!.collectionViewLayout();
            }else
            {
                let layout = UICollectionViewFlowLayout.init();
                layout.scrollDirection = .vertical
                flowLayout = layout;
            }
        }else
        {
            let layout = UICollectionViewFlowLayout.init();
            layout.scrollDirection = .vertical
        }
        
        super.init(frame: CGRect.zero, collectionViewLayout:flowLayout!)
        self.onConfiguration();

    }
    
   public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.onConfiguration();
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc open func longPressGestureAction(_ gesture:UILongPressGestureRecognizer)
    {
        switch gesture.state {
        case .began:
    
            let indexPath = self.indexPathForItem(at: gesture.location(in: self));
            if indexPath == nil {
                break;
            }

            currentMoveIndexPath = indexPath
            let cell = self.cellForItem(at: indexPath!);
            if  cell == nil {
                break
            }
            self.bringSubviewToFront(cell!);
            self.beginInteractiveMovementForItem(at: indexPath!);
            break;
        
        case .changed:
            
            if onlyMoveInSameSection == true {
                let indexPath = self.indexPathForItem(at: gesture.location(in: self));
                if indexPath != nil, indexPath?.section != currentMoveIndexPath?.section {
                    cancelInteractiveMovement()
                    currentMoveIndexPath = nil
                    break
                }
            }
            
            self.updateInteractiveMovementTargetPosition(gesture.location(in: self));
            break;
        
        case .ended:
            currentMoveIndexPath = nil
            self.endInteractiveMovement();
            break;
        
        default:
            currentMoveIndexPath = nil
            self.endInteractiveMovement();
            
        
        }
        
    }
    
   
}

public typealias ZHCollectionViewLayoutClosure = (_ height:CGFloat)->();

open class ZHCollectionViewLayout: UICollectionViewFlowLayout {
    
    public var space:CGFloat = kMargin;

    public override init() {
        super.init();
       
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let s_layoutAttributes = super.layoutAttributesForElements(in: rect) else { return []};
        var layoutAttributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]();
        layoutAttributes.append(contentsOf: s_layoutAttributes)
        
        var t_layoutAttributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]();
        
        
        for i in 0..<layoutAttributes.count {

            let current:UICollectionViewLayoutAttributes = layoutAttributes[i];

            let previous:UICollectionViewLayoutAttributes? = (i==0) ? nil:layoutAttributes[i-1];

            let next:UICollectionViewLayoutAttributes? = ((i+1)==layoutAttributes.count) ? nil:layoutAttributes[i+1];

            t_layoutAttributes.append(current);


            let current_y:CGFloat  = current.frame.maxY;

            let previous_y:CGFloat  = (previous != nil) ? previous!.frame.maxY:0;

            let next_y:CGFloat  = (next != nil) ? next!.frame.maxY:0;

            if current_y != previous_y && current_y != next_y {

                if current.representedElementKind == UICollectionView.elementKindSectionHeader {
                    layoutAttributes.removeAll();

                } else if current.representedElementKind == UICollectionView.elementKindSectionFooter {

                    layoutAttributes.removeAll();

                }else {
                    self.updateCellFrame(layoutAttributes: &t_layoutAttributes)
                }

            }else if current_y != next_y {

                self.updateCellFrame(layoutAttributes: &t_layoutAttributes);
            }


        }

        return layoutAttributes;
    }
    
    open func updateCellFrame(layoutAttributes: inout [UICollectionViewLayoutAttributes]) {
        
        var x:CGFloat = kSpace;
        
        for i in 0..<layoutAttributes.count
        {
            let attributes = layoutAttributes[i];
            
            var rect:CGRect = attributes.frame;
            rect.origin.x = x;
            attributes.frame = rect;
            x += rect.size.width + self.space;

        }
        layoutAttributes.removeAll();
        
    }
}



