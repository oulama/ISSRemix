//
//  LiveLocationStatusView.swift
//  ISSRemix
//
//  Created by Hamza DOUMARI on 1/28/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit

protocol LiveLocationStatusViewFactory: AnyObject {
    static func make() -> LiveLocationStatusViewProtocol
}

protocol LiveLocationStatusViewProtocol: AnyObject {
    func updateColor(viewData: LiveLocationStatusViewData)
    func setDelegate(delegate: LiveLocationStatusViewDelegate)
}

protocol LiveLocationStatusViewDelegate: AnyObject {
    func didClickLocationStatusView()
}

class LiveLocationStatusView: UIView {
    
    private let containerSize: CGFloat = 40
    private weak var delegate: LiveLocationStatusViewDelegate?
    private var viewData: LiveLocationStatusViewData?{
        didSet{
            DispatchQueue.main.async {
                self.statusImageView.tintColor = self.viewData?.color
                self.messageLabel.text = self.viewData?.message
            }
        }
    }
    private lazy var statusImageViewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(white: 0, alpha: 0.5)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    private lazy var statusImageView: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Info")
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    private lazy var messageLabelContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(white: 0, alpha: 0.5)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.alpha = 0
        return container
    }()
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupImageContainer()
        setupImage()
        setupMessage()
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LiveLocationStatusViewFactory
extension LiveLocationStatusView: LiveLocationStatusViewFactory{
    static func make() -> LiveLocationStatusViewProtocol {
        let view = LiveLocationStatusView()
        return view
    }
}

// MARK: - LiveLocationStatusViewProtocol
extension LiveLocationStatusView: LiveLocationStatusViewProtocol{
    func setDelegate(delegate: LiveLocationStatusViewDelegate) {
        self.delegate = delegate
    }
    
    func updateColor(viewData: LiveLocationStatusViewData) {
        self.viewData = viewData
    }
}

// MARK: - LiveLocationStatusViewPrivate
private extension LiveLocationStatusView{
  private func setupImage(){
      statusImageViewContainer.addSubview(statusImageView)
      statusImageView.translatesAutoresizingMaskIntoConstraints = false
      statusImageView.centerXAnchor.constraint(equalTo: self.statusImageViewContainer.centerXAnchor).isActive = true
      statusImageView.centerYAnchor.constraint(equalTo: self.statusImageViewContainer.centerYAnchor).isActive = true
      statusImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
      statusImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
  }
  
  private func setupImageContainer(){
      addSubview(statusImageViewContainer)
      statusImageViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoClicked)))
      statusImageViewContainer.widthAnchor.constraint(equalToConstant: containerSize).isActive = true
      statusImageViewContainer.heightAnchor.constraint(equalToConstant: containerSize).isActive = true
      statusImageViewContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      statusImageViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
      statusImageViewContainer.layer.cornerRadius = containerSize/2
      statusImageViewContainer.layer.masksToBounds = true
  }
  
  private func setupMessage(){
      addSubview(messageLabelContainer)
      messageLabelContainer.addSubview(messageLabel)
      
      messageLabel.trailingAnchor.constraint(equalTo: self.messageLabelContainer.trailingAnchor, constant: -4).isActive = true
      messageLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
      messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      
      messageLabelContainer.trailingAnchor.constraint(equalTo: statusImageViewContainer.leadingAnchor, constant: -4).isActive = true
      messageLabelContainer.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8).isActive = true
      messageLabelContainer.topAnchor.constraint(equalTo: messageLabel.topAnchor).isActive = true
      messageLabelContainer.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor).isActive = true
      messageLabelContainer.layer.cornerRadius = 15
      messageLabelContainer.layer.masksToBounds = true
  }
  
  private func setView(){
      self.heightAnchor.constraint(equalToConstant: containerSize).isActive = true
      self.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor).isActive = true
  }
  
  @objc private func infoClicked(){
      delegate?.didClickLocationStatusView()
      let alpha: CGFloat = messageLabelContainer.alpha == 1 ? 0 : 1
      UIView.animate(withDuration: 0.5) {
          self.messageLabelContainer.alpha = alpha
      }
      
  }
    
}


