//
//  Model+CellConfigurable.swift
//  Placeholder
//
//  Created by Todd Olsen on 4/28/17.
//  Copyright © 2017 proxpero. All rights reserved.
//

protocol CellConfigurable {
    associatedtype Cell
    func configureCell(_ cell: Cell) -> ()
}

extension User: CellConfigurable {
    func configureCell(_ cell: UserCell) {
        cell.textLabel?.text = name
    }
}

extension Album: CellConfigurable {
    func configureCell(_ cell: AlbumCell) {
        cell.textLabel?.text = title
    }
}

import UIKit

extension Photo: CellConfigurable {

    // This is going to get used a lot so keep a reference here.
    private static let placeholder = UIImage.placeholder(with: .lightGray, size: CGSize(width: 44, height: 44))

    func configureCell(_ cell: PhotoCell) {

        // Set the cell's text label to the the photo's title.
        cell.textLabel?.text = title

        // Set the cell's image to a placeholder until and image is found.
        cell.imageView?.image = Photo.placeholder

        // Asyncronously load the (possibly cached) image. Update on the
        // main queue.
        CachedWebservice.shared.load(thumbnailResource).onResult { result in
            if case .success(let image) = result {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        }

    }
}
