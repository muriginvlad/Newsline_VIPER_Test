//
//  DescriptionViewController.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import UIKit
import SnapKit
import Kingfisher

class DescriptionViewController: UIViewController, DescriptionViewProtocol {
        
    private let newsDescriptionLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(15)
        label.numberOfLines = 0
        return label
    }()
    
    private let backButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("Назад", for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(18)
        label.numberOfLines = 5
        label.textAlignment = .center
        return label
    }()
    
    private let newsSourceLabel : UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(10)
        label.numberOfLines = 1
        return label
    }()
    
    private var imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "newspaper")
        return image
    }()
    
    private var newsData: NewsModel
    
    var presenter: DescriptionPresenterProtocol!
    var configurator: DescriptionConfiguratorProtocol = DescriptionConfigurator()
    
    init(news: NewsModel) {
        self.newsData = news
        self.titleLabel.text = news.title
        self.newsSourceLabel.text = "Источник: " +  news.source
        self.newsDescriptionLabel.text = news.descriptionNews

        if let imgUrl = news.urlToImage {
            if let URL = URL(string: imgUrl) {
                self.imageView.kf.setImage(with: URL)
            }
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        configurationUI()
    }
    
    private func configurationUI(){
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(newsDescriptionLabel)
        view.addSubview(newsSourceLabel)
        view.addSubview(backButton)

        setupConstraints()
        newsDescriptionLabel.sizeToFit()
    }
    
    private func setupConstraints() {
        
        self.imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(10)
            make.right.equalTo(-10)
            make.height.lessThanOrEqualTo(300)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.lessThanOrEqualTo(100)
        }
        
        self.newsDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.lessThanOrEqualTo(newsSourceLabel.snp.top)
        }
        
        self.newsSourceLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(backButton.snp.top).inset(20)
            make.height.equalTo(10)
        }
        
        self.backButton.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().inset(30)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
    }
        
    @objc func backButtonAction(sender: UIButton!) {
        presenter.dismiss()
    }
}
