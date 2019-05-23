//
//  ImageView.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/23/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    private var currentTask: URLSessionDataTask?
    func downloaded(from url: URL) {
        currentTask?.cancel()
        currentTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }
        currentTask?.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }

}
