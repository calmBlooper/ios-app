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
    @IBOutlet  weak var name: UILabel!
    @IBOutlet  weak var time: UILabel!
    @IBOutlet  weak var domain: UILabel!
    @IBOutlet  weak var savedB: UIButton!
    @IBOutlet  weak var title: UILabel!
    @IBOutlet  weak var upsB: UIButton!
    @IBOutlet weak var shareBH: UIButton!
    @IBOutlet  weak var commentsB: UIButton!
    @IBOutlet  weak var imageHolder: UIImageView!
    var postId:String?="default"
    var subreddit:String?="default"
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        self.name.text=nil
        self.time.text=nil
        self.domain.text=nil
        self.title.text=nil
        self.imageHolder.image=nil
        self.postId="default"
        self.subreddit="default"
    }
    
    // MARK: - Configuration
    
    func configure(for post: ResponsePost){
        self.name.text="u/\(post.author)"
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
        self.postId=post.id
        self.subreddit="EarthPorn"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired=2
        self.addGestureRecognizer(tap)
        self.shareBH.addTarget(self,
                               action: #selector(shareBClicked),
                               for: .touchUpInside)
        // Initialization code
    }
    
    
    @objc func shareBClicked(){
        guard let data = URL(string: "https://www.reddit.com/r/\(self.subreddit ?? "default")/comments/\(self.postId ?? "default")") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
     
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
        print("Shared")
    }
    
    
    @objc func doubleTapped() {
        self.savedB.isSelected=true;
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
