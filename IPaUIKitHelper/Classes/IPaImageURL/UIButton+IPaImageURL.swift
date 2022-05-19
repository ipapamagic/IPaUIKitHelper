//
//  UIButton+IPaImageURL.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/27.
//

import UIKit
import IPaDownloadManager
import IPaFileCache
private var imageUrlHandle: UInt8 = 0
private var backgroundImageUrlHandle: UInt8 = 0
private var downloadImageOperationHandle: UInt8 = 0
private var downloadBGOperationHandle: UInt8 = 0
extension UIButton {

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
    fileprivate var _backgroundImageUrl:URL? {
        get {
            return objc_getAssociatedObject(self, &backgroundImageUrlHandle) as? URL
        }
        set {
            objc_setAssociatedObject(self, &backgroundImageUrlHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate var downloadImageOperation:Operation? {
        get {
            return objc_getAssociatedObject(self, &downloadImageOperationHandle) as? Operation
        }
        set {
            objc_setAssociatedObject(self, &downloadImageOperationHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    fileprivate var downloadBGImageOperation:Operation? {
        get {
            return objc_getAssociatedObject(self, &downloadBGOperationHandle) as? Operation
        }
        set {
            objc_setAssociatedObject(self, &downloadBGOperationHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
   
    @objc open var imageUrl:URL? {
        get {
            return _imageUrl
        }
        set {
            setImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var backgroundImageUrl:URL? {
        get {
            return _backgroundImageUrl
        }
        set {
            setBackgroundImageUrl(newValue, defaultImage: nil)
        }
    }
    @objc open var imageURLString:String? {
        get {
            return _imageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string:urlString) {
                setImageUrl(url, defaultImage: nil)
            }
            else {
                setImageUrl(nil, defaultImage: nil)
            }
        }
    }
    @objc open var backgroundImageURLString:String? {
        get {
            return _backgroundImageUrl?.absoluteString
        }
        set {
            if let urlString = newValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string:urlString) {
                setBackgroundImageUrl(url, defaultImage: nil)
            }
            else {
                setBackgroundImageUrl(nil, defaultImage: nil)
            }
        }
    }
    @objc open func setImageUrl(_ imageUrl:URL?,defaultImage:UIImage?) {
        self.setImage(defaultImage, for: .normal)
        self._imageUrl = imageUrl
        if let imageUrl = imageUrl {
            
            if let data = IPaFileCache.shared.cacheData(for: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    self.setImage(image, for: .normal)
                })
                return
            }
            downloadImageOperation = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                self.downloadImageOperation = nil
                switch(result) {
                case .success(let (_,url)):
                    do {
                        let data = try Data(contentsOf: url)
                        IPaFileCache.shared.setCache(data, for: imageUrl)
                        guard  imageUrl == self._imageUrl else {
                            return
                        }
                        
                        if  let image = UIImage(data: data) {

                            DispatchQueue.main.async(execute: {
                                
                                self.setImage(image, for: .normal)
                            })
                            
                        }
                    }
                    catch let error {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    @objc open func setBackgroundImageUrl(_ imageUrl:URL?,defaultImage:UIImage?) {
        self.setBackgroundImage(defaultImage, for: .normal)
        self._backgroundImageUrl = imageUrl
        if let imageUrl = imageUrl {
            if let data = IPaFileCache.shared.cacheData(for: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async(execute: {
                    self.setBackgroundImage(image, for: .normal)
                })
                return
            }
            downloadBGImageOperation = IPaDownloadManager.shared.download(from: imageUrl) { (result) in
                self.downloadBGImageOperation = nil
                switch(result) {
                case .success(let (_,url)):
                    do {
                        let data = try Data(contentsOf: url)
                        IPaFileCache.shared.setCache(data, for:  imageUrl)
                        guard imageUrl == self._backgroundImageUrl else {
                            return
                        }
                        
                        if  let image = UIImage(data: data)                             {
                            self.setBackgroundImage(image, for: .normal)
                        }
                    }
                    catch let error {
                        print(error)
                    }
                    
                case .failure( _):
                    break
                }
            }
        }
    }
}
