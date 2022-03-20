//
//  SettingsViewController.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import UIKit
import SnapKit
import Kingfisher

class SettingsViewController: UIViewController, SettingsViewProtocol, UITextFieldDelegate {

    private var titleOneLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(15)
        label.text = "Показывать описание:"
        return label
    }()
    
    private var switchOne: UISwitch = {
        var toggle = UISwitch()
        toggle.tag = 0
        toggle.addTarget(self, action: #selector(didTapAdvertise), for:UIControl.Event.valueChanged)
        return toggle
    }()
    
    private var titleSourceOneLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(15)
        label.text = "Загружать новости из Newsapi "
        return label
    }()

    private var switchSourceOne: UISwitch = {
        var toggle = UISwitch()
        toggle.tag = 1
        toggle.addTarget(self, action: #selector(didTapAdvertise), for:UIControl.Event.valueChanged)
        return toggle
    }()
    
    private var titleSourceTwoLabel: UILabel = {
        var label = UILabel()
        label.font = label.font.withSize(15)
        label.text = "Загружать новости из MediaStack"
        return label
    }()

    private var switchSourceTwo: UISwitch = {
        var toggle = UISwitch()
        toggle.tag = 2
        toggle.addTarget(self, action: #selector(didTapAdvertise), for:UIControl.Event.valueChanged)
        return toggle
    }()
    
    private let saveButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("Сохранить настройки", for: .normal)
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var intervalField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Интервал обновлений новостей"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.numberPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()

    
    var presenter: SettingsPresenterProtocol!
    var configurator: SettingsConfiguratorProtocol = SettingsConfigurator()
    
    var showDetail = false
    var newsSources: [String] = []
    
    init() {
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.backgroundColor = .white
        intervalField.delegate = self
        
        view.addSubview(titleOneLabel)
        view.addSubview(switchOne)
        view.addSubview(intervalField)
        view.addSubview(saveButton)
        view.addSubview(titleSourceOneLabel)
        view.addSubview(switchSourceOne)
        view.addSubview(titleSourceTwoLabel)
        view.addSubview(switchSourceTwo)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        self.titleOneLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(5)
            make.left.equalTo(10)
            make.right.equalTo(switchOne.snp.left).inset(-10)
            make.height.lessThanOrEqualTo(30)
        }
        
        self.switchOne.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(titleOneLabel.snp.centerY)
        }

        self.titleSourceOneLabel.snp.makeConstraints { make in
            make.top.equalTo(titleOneLabel.snp.bottom).offset(20)
            make.left.equalTo(10)
            make.right.equalTo(switchOne.snp.left).inset(-10)
            make.height.lessThanOrEqualTo(30)
        }
        
        self.switchSourceOne.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(titleSourceOneLabel.snp.centerY)
        }
        
        self.titleSourceTwoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleSourceOneLabel.snp.bottom).offset(20)
            make.left.equalTo(10)
            make.right.equalTo(switchOne.snp.left).inset(-10)
            make.height.lessThanOrEqualTo(30)
        }
        
        self.switchSourceTwo.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(titleSourceTwoLabel.snp.centerY)
        }
        
        
        self.intervalField.snp.makeConstraints { make in
            make.top.equalTo(self.titleSourceTwoLabel.snp.bottom).offset(20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.lessThanOrEqualTo(40)
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.left.equalTo(10)
            make.top.equalTo(self.intervalField.snp.bottom).offset(20)
        }
        
        
    }
    
    func setup(news: [String], showDetail: Bool) {
        self.newsSources = news
        self.showDetail = showDetail
    }
    
    @objc func didTapAdvertise(mySwitch: UISwitch) {
        if mySwitch.tag == 0 {
            showDetail = mySwitch.isOn
        }
    }
    
    
    @objc func saveButtonAction() {
        newsSources.removeAll()
        
        if switchSourceOne.isOn {
            newsSources.append("Newsapi")
        }
        
        if switchSourceTwo.isOn  {
            newsSources.append("MediaStack")
        }
        
        presenter.updateSettings(news: newsSources,showDetail: showDetail)
        
        }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
