//
//  FullScreenViewController.swift
//  TMDB
//
//  Created by Докин Андрей (IOS) on 28.04.2021.
//

import UIKit
import RxSwift

class FullScreenViewController: UIViewController {
    
//    MARK: - Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let disposeBag = DisposeBag()
    var contentForm: ContentForm = .portrait
    var viewModel: FullScreenViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTaped))
        return tap
    }()
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        var value = UIInterfaceOrientation.portrait.rawValue
        switch contentForm {
        case .landscape:
            appDelegate.deviceOrientation = .landscape
                value = UIInterfaceOrientation.landscapeLeft.rawValue
        default:
            appDelegate.deviceOrientation = .portrait
                value = UIInterfaceOrientation.portrait.rawValue
        }
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        appDelegate.deviceOrientation = .portrait
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    
//    MARK: - Methods

    fileprivate func bindViewModel() {

        viewModel.imageCellViewModel.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            $0.imageData { (data) in
                guard let data = data else { return }
                self.imageView.image = UIImage(data: data)
            }
        }).disposed(by: disposeBag)
        
        viewModel.contentForm.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.contentForm = $0
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .black
    }
    
    fileprivate func setupHierarhy() {
        view.addGestureRecognizer(tap)
        view.addSubview(imageView)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    @objc fileprivate func didTaped() {
        dismiss(animated: true, completion: nil)
    }
    
}
