//
//  PostCell.swift
//  ios101-project5-tumblr
//
//  Created by Samuel Uche on 10/29/25.
//


//
//  PostCell.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class PostCell: UITableViewCell {

    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(photoImageView)
        contentView.addSubview(summaryLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            photoImageView.heightAnchor.constraint(equalToConstant: 250),

            summaryLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            summaryLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with post: Post) {
        summaryLabel.text = post.summary

        if let photo = post.photos.first {
            let request = ImageRequest(url: photo.originalSize.url)
            Nuke.ImagePipeline.shared.loadImage(with: request) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.photoImageView.image = response.image
                case .failure(let error):
                    print("❌ Failed to load image:", error)
                }
            }
        }
    }

}
