//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModelProtocol
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data
    
//    fileprivate let data = Post.make()
//
//    private let user: User
//
//    init(user: User) {
//        self.user = user
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
        
        return tableView
    }()
    
    private enum CellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
        case custom = "CustomTableViewCell_ReuseID"
    }
    
    private enum HeaderFooterReuseID: String {
        case base = "TableSectionFooterHeaderView_ReuseID"
    }
    
    
    // MARK: - Lifecycle
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        view.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Private
    
    private func setupView() {
        
        #if DEBUG
        view.backgroundColor = .systemPink
        #else
        view.backgroundColor = .orange
        #endif
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        
        let headerTableView = HeaderTableVIew()
        headerTableView.update(user: viewModel.model.user)
        tableView.setAndLayout(headerView: headerTableView)
        tableView.tableFooterView = UIView()
        
        headerTableView.onButtonTapped = { [weak self] in
            let navigationController = NavigationViewController()
            navigationController.view.backgroundColor = .white
            navigationController.title = "MAP"
            
            self?.navigationController?.pushViewController(navigationController, animated: true)
//            self?.present(navigationController, animated: true, completion: nil)
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        tableView.register(
            BaseTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
        
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.custom.rawValue
        )
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Extension

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        2
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.model.data.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.custom.rawValue,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.accessoryType = .none
            
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.base.rawValue,
                for: indexPath
            ) as? BaseTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.accessoryType = .none
            cell.update(viewModel.model.data[indexPath.row])
            
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if indexPath.section == 0 {
//            let nextViewController = PhotosViewController()
//            
//            navigationController?.pushViewController(
//                nextViewController,
//                animated: true
//            )
            viewModel.didTapPhotoCollection()
        } else {return}
    }
}
