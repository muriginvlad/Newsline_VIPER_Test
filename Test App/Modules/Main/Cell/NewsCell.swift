//
//  NewsCell.swift
//  Test App
//
//  Created by Vladislav on 16.03.2022.
//

import Foundation
import SnapKit
import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let newsDescriptionLabel: UILabel = {
        var label = UILabel()
        label.isHidden = true
        label.font = label.font.withSize(15)
        label.numberOfLines = 0
        return label
    }()
    
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(15)
        label.numberOfLines = 2
        return label
    }()
    
    private let newsSourceLabel : UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(10)
        label.numberOfLines = 1
        return label
    }()
    
    var newsImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    //
    //    override func sizeThatFits(_ size: CGSize) -> CGSize {
    //        layout()
    //        return contentView.frame.size
    //    }
    
    private func layout() {
        
        containerView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        newsImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.left.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(        newsImageView.snp.centerY)
            make.left.equalTo(        newsImageView.snp.right).offset(5)
            make.right.equalTo(-5)
            make.height.equalTo(        newsImageView.snp.height)
        }
        
        newsDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        if newsDescriptionLabel.isHidden  {
            newsSourceLabel.snp.makeConstraints { make in
                make.top.equalTo(        newsImageView.snp.bottom ).offset(5)
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.bottom.equalTo(-5)
                make.height.equalTo(10)
            }
            
        } else if !newsDescriptionLabel.isHidden {
            newsSourceLabel.snp.makeConstraints { make in
                make.top.equalTo(newsDescriptionLabel.snp.bottom ).offset(5)
                make.left.equalTo(10)
                make.right.equalTo(-10)
                make.bottom.equalTo(-5)
                make.height.equalTo(10)
            }
        }
        
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
            make.width.height.equalTo(containerView)
        }
    }
    
    
    func setup(with model: NewsModel, showDescription: Bool ) {
        titleLabel.text = model.title
        
        newsSourceLabel.text = "Источник: " +  model.source
        
        if let imgUrl = model.urlToImage {
            if let URL = URL(string: imgUrl) {
                newsImageView.kf.setImage(with: URL)
            }
        } else {
            newsImageView.image = UIImage(systemName: "newspaper")
        }
        
        if model.newsRead {
            newsSourceLabel.textColor = .gray
            newsDescriptionLabel.textColor = .gray
            titleLabel.textColor = .gray
            newsImageView.alpha = 0.5
        } else {
            newsSourceLabel.textColor = .black
            newsDescriptionLabel.textColor = .black
            titleLabel.textColor = .black
            newsImageView.alpha = 1
        }
        
        if showDescription {
            newsDescriptionLabel.isHidden = false
            newsDescriptionLabel.text = model.descriptionNews
        } else {
            newsDescriptionLabel.isHidden = true
        }
        
        layoutSubviews()
    }
    
    private func addSubviews() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(newsDescriptionLabel)
        containerView.addSubview(newsSourceLabel)
        containerView.addSubview(        newsImageView)
        contentView.addSubview(containerView)
    }
    
}
