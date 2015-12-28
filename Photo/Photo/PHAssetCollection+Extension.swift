//
//  PHAssetCollection+Extension.swift
//  Photo
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/12/26.
//  Copyright © 2015年 阳君. All rights reserved.
//

import UIKit
import Photos

/// 错误输出
private let completionHandler = { (success: Bool, error: NSError?) -> Void in
    if !success {
        print(error)
    }
}

/// PHAssetCollection扩展
public extension PHAssetCollection {
    
    // MARK: - 获取PHAsset集合
    /// 获取PHAsset集合
    ///
    /// - parameter options : PHFetchOptions?
    ///
    /// - returns: [PHAsset]
    func fetchAssetsWithOptions(options: PHFetchOptions?) -> [PHAsset] {
        var assets = [PHAsset]()
        let fetchResult = PHAsset.fetchAssetsInAssetCollection(self, options: options)
        fetchResult.enumerateObjectsUsingBlock { (obj: AnyObject, index: Int, umPointer: UnsafeMutablePointer<ObjCBool>) -> Void in
            if let asset = obj as? PHAsset {
                assets.append(asset)
            }
        }
        return assets
    }
    
    // MARK: - 创建相薄
    /// 创建相薄
    ///
    /// - parameter title: 相薄名
    ///
    /// - returns: void
    class func creationWithTitle(title: String) {
        let changeBlock: dispatch_block_t = {
            PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(title)
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: 修改专辑名
    /// 修改相薄名
    ///
    /// - parameter title: 相薄名
    ///
    /// - returns: void
    func renameLocalizedTitle(title: String) {
        let changeBlock: dispatch_block_t = {
            let aCChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self)
            aCChangeRequest?.title = title
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    // MARK: 删除PHAssetCollection
    /// 删除专辑
    ///
    /// - returns: void
    func delete() {
        let changeBlock: dispatch_block_t = {
            PHAssetCollectionChangeRequest.deleteAssetCollections([self])
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
}
