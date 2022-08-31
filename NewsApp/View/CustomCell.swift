//
//  CustomCell.swift
//  NewsApp
//
//  Created by Virtual Machine on 25/08/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var NewView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    
    private var viewModel: NewsCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCellCustom(model: Article) {
        self.viewModel = NewsCellViewModel(article: model)
        self.titleLbl.text = self.viewModel?.title
        self.descriptionLbl.text = self.viewModel?.description
        DispatchQueue.global().async {
                if let urlPhoto = self.viewModel?.photoUrl {
                    do {
                        let data = try Data(contentsOf: urlPhoto)
                        DispatchQueue.main.async {
                            self.newImage.image = UIImage(data: data)
                        }
                    } catch _{ }
            }
        }
    }
}
