//
//  UIImageView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/26.
//

import UIKit
import IPaLog
import IPaDownloadManager
import IPaFileCache
private var imageUrlHandle: UInt8 = 0
private var highlightedImageUrlHandle: UInt8 = 0
private var downloadOperationHandle: UInt8 = 0
extension UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    fileprivate var _imageUrl:URL? {
        get {
            return objc_getAssociatedObject(self, &imageUrlHandle) as? URL
        }
        set {
            objc_setAssociatedObject(self, &imageUrlHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    fileprivate var _highlightedImageUrl:URL? {
        get {
            return objc_getAssociatedObject(self, &highlightedImageUrlHandle) as? URL
        }
        set {
            objc_setAssociatedObject(self, &highlightedImageUrlHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate var downloadOperation:Operation? {
        get {
            return objc_getAssociatedObject(self, &downloadOperationHandle) as? Operation
        }
        set {
            objc_setAssociatedObject(self, &downloadOperationHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @objc open var imageUrl:URL? {
        get {
            return _imageUrl
        }
        set {
            setImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var highlightedImageUrl:URL? {
        get {
            return _highlightedImageUrl
        }
        set {
            setHighlightedImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var imageURLString:String? {
        get {
            return _imageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: urlString) {
                setImageUrl(url, defaultImage: nil)
            }
            else {
                setImageUrl(nil, defaultImage: nil)
            }
        }
    }
    @objc open var highlightedImageURLString:String? {
        get {
            return _highlightedImageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: urlString) {
                setHighlightedImageUrl(url, defaultImage: nil)
            }
        }
    }
    @objc open func setImageUrlString(_ imageUrlString:String?,defaultImage:UIImage?,downloadCompleted: ((UIImage?)->())? = nil) {
        var url:URL?
        if let imageUrlString = imageUrlString {
            url = URL(string:imageUrlString)
        }
        
        self.setImageUrl(url, defaultImage: defaultImage,downloadCompleted:downloadCompleted)
        
    }
    @objc open func setImageUrl(_ imageUrl:URL?,defaultImage:UIImage? = nil,downloadCompleted: ((UIImage?)->())? = nil) {
        _imageUrl = imageUrl
        self.image = defaultImage
        if let imageUrl = imageUrl {
            if let data = IPaFileCache.shared.cacheData(for: imageUrl), let image = UIImage(data: data) {
                self.image = image
                return
            }
            downloadOperation = IPaDownloadManager.shared.download(from: imageUrl, complete: { (result) in
                self.downloadOperation = nil
                switch(result) {
                case .success(let (_,url)):
                    do {
                        let data = try Data(contentsOf: url)
                        IPaFileCache.shared.setCache(data, for: imageUrl)
                    
                        if  let image = UIImage(data: data) {
                            
                            DispatchQueue.main.async(execute: {
                                downloadCompleted?(image)
                                guard imageUrl == self._imageUrl else {
                                    return
                                }
                                self.image = image
                                
                            })
                            
                        }
                    }
                    catch (let error) {
                        IPaLog(error.localizedDescription)
                    }
                case .failure(let error):
                    IPaLog(error.localizedDescription)
                }
            })
        }
    }

    @objc open func setHighlightedImageUrl(_ imageUrl:URL?,defaultImage:UIImage?,downloadCompleted: ((UIImage?)->())? = nil) {
        self.highlightedImage = defaultImage
        if let imageUrl = imageUrl {
            if let data = IPaFileCache.shared.cacheData(for: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    self.highlightedImage = image
                })
                return
            }
            _ = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                switch(result) {
                case .success(let (_,url)):
                    do {
                        let data = try Data(contentsOf: url)
                        IPaFileCache.shared.setCache(data, for: imageUrl)
                        
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async(execute: {
                                downloadCompleted?(image)
                                guard imageUrl == self._highlightedImageUrl else {
                                    return
                                }
                                self.highlightedImage = image
                                
                            })
                        }
                    }
                    catch (let error) {
                        IPaLog(error.localizedDescription)
                    }
                case .failure( _):
                    break
                }
            }
        }
    }
    
}
