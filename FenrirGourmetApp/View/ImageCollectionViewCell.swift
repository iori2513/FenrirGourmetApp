//
//  ImageCollectionViewCell.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/26.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(foodImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        foodImageView.frame = contentView.bounds
    }
    
    public func getImageByUrl(url: String) {
        guard let url = URL(string: url) else {return}
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else {return}
            foodImageView.image = image
        } catch let error {
            print(error.localizedDescription)
        }
        return
    }
    
    
}
