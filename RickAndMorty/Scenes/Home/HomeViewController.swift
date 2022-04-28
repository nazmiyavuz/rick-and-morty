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
    private let tableView: UITableView = UITableView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        addSubViews()
    }
    
    // MARK: - Services
    
    // MARK: - Private Functions
    
    // MARK: - Action
    
    // MARK: - Helpers
    
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubViews() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Configure
extension HomeViewController {
    
    private func configureContents() {
        navigationItem.title = viewModel.title
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(CharacterCell.self)
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
        viewModel.navigateToFilterScreen()
    }
}

// MARK: - UIScrollViewDelegate
extension RecipesViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height && viewModel.isPagingEnabled && viewModel.isRequestEnabled {
            viewModel.fetchMorePages()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecipesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecipeCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellViewModel = viewModel.cellItem(for: indexPath)
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let footer: ActivityIndicatorFooterView = collectionView.dequeueReusableCell(ofKind: kind, for: indexPath)
        loadingFooterView = footer
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingFooterView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String,
                        at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingFooterView?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension RecipesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRecipe(at: indexPath)
    }
}

// swiftlint:disable line_length
// MARK: - UICollectionViewDelegateFlowLayout
extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWitdh = view.frame.width
        let recipeImageHeight = cellWitdh - 30
        let otherCellItemsHeight = CGFloat(175)
        let cellHeight = recipeImageHeight + otherCellItemsHeight
        return CGSize(width: cellWitdh, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = viewModel.isPagingEnabled ? 100 : 0
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}
// swiftlint:enable line_length
