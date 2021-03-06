//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Nazmi Yavuz on 27.04.2022.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController<HomeViewModel> {
    
    // MARK: - Views
    lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.backgroundColor = .appPrimaryBackground
        $0.showsVerticalScrollIndicator = false
        $0.register(CharacterCell.self)
        return $0
    }(UITableView())
    
    private var observer: NSObjectProtocol?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        addSubViews()
        viewModel.fetchCharacters()
        subscribeViewModelEvents()
    }
    
    func subscribeViewModelEvents() {
        
        viewModel.didSuccessFetchCharacters = { [weak self] (isFirstLoading, indexPathList) in
            guard let self = self else { return }
            switch isFirstLoading {
            case true:
                DispatchQueue.main.async {
                    self.viewModel.isFirstLoading = false
                    self.tableView.reloadData()
                    guard self.tableView.numberOfRows(inSection: 0) > 0 else { return } // Safety Check
                    self.tableView.scrollToRow(at: [0, 0], at: .top, animated: true)
                }
                
            case false:
                self.tableView.insertRows(at: indexPathList, with: .automatic)
                
            }
        }
    }
    
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubViews() {
        view.addSubview(tableView)
        view.backgroundColor = .appPrimaryBackground
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Configure
extension HomeViewController {
    
    private func configureContents() {
        navigationItem.title = "Rick and Morty"
        tableView.dataSource = self
        tableView.delegate = self
        configureFilterRightBarButton()
    }
    
    private func configureFilterRightBarButton() {
        let image = UIImage.filterIcon
        let filterBarButton = UIBarButtonItem(
            image: image, style: .done, target: self, action: #selector(filterButtonTapped)
        )
        navigationItem.rightBarButtonItem = filterBarButton
    }
}

// MARK: - Actions
extension HomeViewController {
    
    @objc
    private func filterButtonTapped() {
//        addObserver()
        viewModel.navigateToFilterScreen(fromVC: self)
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let reloadingIndex = viewModel.cellItems.count - 5
        guard reloadingIndex == indexPath.row && viewModel.isPagingEnabled else { return }
        
        viewModel.fetchMoreCharacters()
    }
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(for: indexPath)
        let cellViewModel = viewModel.cellItem(for: indexPath)
        cell.set(with: cellViewModel)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.cellItem(for: indexPath)
        let name = item.characterName
        Logger.debug("Selected character: \(name)")
    }
}

extension HomeViewController: FilterViewControllerDelegate {
    func didSendFilter(filter: FilterOption?) {
        viewModel.filter = filter
        viewModel.fetchCharacters()
        Logger.debug("delegate worked")
    }
}
