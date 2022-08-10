//
//  IPaProgressIndicator.swift
//  Pods
//
//  Created by IPa Chen on 2017/6/24.
//
//

import UIKit
import Combine
@available(iOS 13.0, *)
open class IPaProgressIndicator: IPaIndicator {
    var progressCancellable:AnyCancellable?
    open class func show(_ inView:UIView,target:IPaProgressObservable) -> IPaProgressIndicator {
        let indicator = self.show(inView)
        indicator.observer(target)
        return indicator
    }
    open override func removeFromSuperview() {
        super.removeFromSuperview()
        self.progressCancellable?.cancel()
        self.progressCancellable = nil
    }
    func observer(_ target:IPaProgressObservable) {
        self.progressCancellable = target.progressPublisher().sink(receiveValue: { progress in
            DispatchQueue.main.async {
                self.progress = progress
            }
        })
//        .assign(to: \.progress, on: self)
    }
    
    open lazy var progressView:IPaRoundProgressView = {
        let pView = IPaRoundProgressView(frame: .zero)
        pView.progress = 0
        pView.translatesAutoresizingMaskIntoConstraints = false
        pView.backgroundColor = .clear
        return pView
    }()
    open var infoLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    open var contentStackView:UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    open var progress:Double {
        set {
            progressView.progress = CGFloat(newValue)
        }
        get {
            return Double(progressView.progress)
        }
    }
    
    
    deinit {
      
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func initialSetting() {
        super.initialSetting()
        
        
        indicatorBlackView.addSubview(contentStackView)
        let viewDict = ["stackView":contentStackView] as [String : Any]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[stackView]-30-|", options: [], metrics: nil, views:viewDict)
        indicatorBlackView.addConstraints(constraints)
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[stackView]-30-|", options: [], metrics: nil, views: viewDict)
        indicatorBlackView.addConstraints(constraints)
        
        
        let view = UIView(frame: .zero)
        view.addSubview(progressView)
        view.translatesAutoresizingMaskIntoConstraints = false
        progressView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor, multiplier: 1).isActive = true
        view.topAnchor.constraint(equalTo: progressView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: progressView.bottomAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        contentStackView.addArrangedSubview(view)
        contentStackView.addArrangedSubview(infoLabel)
        
        
        
    }
}
