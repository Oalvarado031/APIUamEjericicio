//
//  APIAppUAMExample
//
//
//  Created by Oscar Alvarado 17/10/24
//

import UIKit

class ProductDetailViewController: UIViewController {

    let mainController: MainController
    let selectedProduct: ProductModel?
    let productImageView = UIImageView()
    let nameLabel = UILabel()
    let brandTitleLabel = UILabel()
    let saleLabel = UILabel()
    let detailsLabel = UILabel()
    var purchaseButton: UIButton = UIButton()
    let typeLabel = UILabel()
    private let spacing: CGFloat = 10
    
    init(selectedProduct: ProductModel?, mainController: MainController) {
        self.selectedProduct = selectedProduct
        self.mainController = mainController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? .white : .white
            }
        
        displayProductDetails()
        configureLayout()
    }
    
    func displayProductDetails() {
        guard let selectedProduct = self.selectedProduct else { return }
        nameLabel.text = selectedProduct.title
        detailsLabel.text = selectedProduct.description
        typeLabel.text = selectedProduct.category.capitalized
        brandTitleLabel.text = selectedProduct.brand?.capitalized ?? ""
        saleLabel.text = "\(selectedProduct.discountPercentage)% off"
        
        var buttonConfig: UIButton.Configuration = .borderedTinted()
        buttonConfig.cornerStyle = .medium
        buttonConfig.title = String(format: "$%.2f", selectedProduct.price)

        buttonConfig.image = UIImage(systemName: "cart")
        buttonConfig.imagePlacement = .leading
        buttonConfig.imagePadding = 5
        purchaseButton = UIButton(configuration: buttonConfig)
        
        Task {
            productImageView.image = await mainController.loadImage(url: selectedProduct.thumbnail)
        }
    }
    
    func configureLayout() {
        
        [productImageView, nameLabel, detailsLabel, purchaseButton, typeLabel, saleLabel, brandTitleLabel].forEach { element in
            view.addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        }
        setupImageViewConstraints()
        setupTextElements()
        setupActionButton()
    }
    
    func setupImageViewConstraints() {
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing),
            productImageView.widthAnchor.constraint(equalToConstant: 250),
            productImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupTextElements() {
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        detailsLabel.numberOfLines = 4
        detailsLabel.lineBreakMode = .byTruncatingTail
        typeLabel.font = UIFont.systemFont(ofSize: 14)
        typeLabel.textAlignment = .right
        typeLabel.textColor = .secondaryLabel
        brandTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        brandTitleLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: spacing),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 350),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            brandTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            brandTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            brandTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            brandTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            detailsLabel.topAnchor.constraint(equalTo: brandTitleLabel.bottomAnchor, constant: spacing),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            detailsLabel.heightAnchor.constraint(equalToConstant: 100),
            
            typeLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: spacing),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            typeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            typeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupActionButton() {
        saleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        saleLabel.textAlignment = .right
        NSLayoutConstraint.activate([
            purchaseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -spacing),
            purchaseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            purchaseButton.heightAnchor.constraint(equalToConstant: 45),
            purchaseButton.widthAnchor.constraint(equalToConstant: 150),
            
            saleLabel.bottomAnchor.constraint(equalTo: purchaseButton.topAnchor, constant: -spacing),
            saleLabel.trailingAnchor.constraint(equalTo: purchaseButton.trailingAnchor),
            saleLabel.heightAnchor.constraint(equalToConstant: 18),
            saleLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}


