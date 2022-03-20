//
//  MainViewController.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import UIKit
import SnapKit
import Kingfisher

class MainViewController: UIViewController, MainViewProtocol {
        
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    private var tableView: UITableView = {
        var table = UITableView()
        table.clipsToBounds = true
        table.layer.cornerRadius = 20
        table.register(NewsCell.self, forCellReuseIdentifier: "DefaultCell")
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        return table
    }()
    
    
    private var spinner = UIActivityIndicatorView(style: .large)
    
    private var newsData: [NewsModel] = []
    private var showDescription =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        configurationUI()
    }
    
    private func configurationUI(){
        title = "Новости"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), landscapeImagePhone: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(openSettings))

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(spinner)
       
        setupConstraints()
    }
    
    @objc private func openSettings() {
        presenter.openSettings()
    }
    
    private func setupConstraints(){
        self.tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        self.spinner.snp.makeConstraints{ (make) -> Void in
            make.center.equalTo(self.view)
        }
    }
    
    func showSpiner() {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
    }
    
    func hideSpiner() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
    }

    func showDescriptions(show: Bool){
        self.showDescription = show
        tableView.reloadData()
    }
    
    func dataUpdate(data: [NewsModel]) {
        self.newsData = data.sorted(by: { $0.datePost > $1.datePost})
        tableView.reloadData()
    }
}


extension MainViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")! as! NewsCell
        cell.setup(with: newsData[indexPath.row], showDescription: showDescription)
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         presenter.markNews(title: newsData[indexPath.row].title)
         presenter.openNews(news: newsData[indexPath.row])
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
