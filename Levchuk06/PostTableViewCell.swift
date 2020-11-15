//
//  PostTableViewCell.swift
//  Levchuk06
//
//  Created by Admin on 15.11.2020.
//

import UIKit
import SDWebImage
class PostTableViewCell: UITableViewCell {

    // MARK: - ReuseIdentifier
    static let reuseIdentifier="postCell"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var domain: UILabel!
    @IBOutlet private weak var savedB: UIButton!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var upsB: UIButton!
    @IBOutlet private weak var commentsB: UIButton!
    @IBOutlet private weak var imageHolder: UIImageView!

    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        self.name.text=nil
        self.time.text=nil
        self.domain.text=nil
        self.title.text=nil
        self.imageHolder.image=nil
    }
    
    // MARK: - Configuration
    
    func configure(for post: ResponsePost){
        self.name.text=post.author
        let date = NSDate(timeIntervalSince1970: post.timeCreated)
        self.time.text=" \(Calendar.current.dateComponents([.hour], from: date as Date, to: NSDate() as Date).hour!) hrs"
        self.domain.text=post.domain
        self.title.text=post.title
        if(post.imageUrl.contains(".jpg")||post.imageUrl.contains(".png")||post.imageUrl.contains(".jpeg")||post.imageUrl.contains(".tiff")||post.imageUrl.contains(".gif")) {
        self.imageHolder.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }
        else {
            self.imageHolder.sd_setImage(with: URL(string: "https://brok.land/static/img/picture.png"), placeholderImage: UIImage(named: "placeholder.png"))
        }
        self.upsB.setTitle("\(post.ups)", for: .normal)
        self.commentsB.setTitle("\(post.numComments)", for: .normal)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
