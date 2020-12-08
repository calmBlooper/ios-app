//
//  ViewController.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet  weak var name: UILabel!
    @IBOutlet  weak var time: UILabel!
    @IBOutlet  weak var postTitle: UILabel!
    @IBOutlet  weak var domain: UILabel!
    @IBOutlet  weak var savedB: UIButton!
    @IBOutlet  weak var image: UIImageView!
    @IBOutlet  weak var upsB: UIButton!
    @IBOutlet  weak var commentsB: UIButton!
    @IBOutlet private weak var shareB: UIButton!
    var firstname: String?="default title"
    private var saved: Bool=false
    override func viewDidLoad() {
        super.viewDidLoad()
 
        useCase.fetchTopPosts(subreddit: "EarthPorn", limit: 13, after: nil,onCompletion: showOneImagePost(_:))
        
        //self.upsB.isEnabled=false
       /* useCase.fetchTopPosts(subreddit: "KnightsOfPineapple", limit: 13, after: nil)*/
        
        // Do any additional setup after loading the view.
    }
    func showOneImagePost(_ results: ResponseTop){
        for post in results.posts {
            
            if(post.imageUrl.contains(".jpg")||post.imageUrl.contains(".png")||post.imageUrl.contains(".jpeg")||post.imageUrl.contains(".tiff")||post.imageUrl.contains(".gif")) {
                DispatchQueue.main.async{
                self.name.text=post.author
                let date = NSDate(timeIntervalSince1970: post.timeCreated)
                self.time.text=" \(Calendar.current.dateComponents([.hour], from: date as Date, to: NSDate() as Date).hour!) hrs"
                self.domain.text=post.domain
                self.postTitle.text=post.title
                    self.image.sd_setImage(with: URL(string: post.imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                self.upsB.setTitle("\(post.ups)", for: .normal)
                self.commentsB.setTitle("\(post.numComments)", for: .normal)
                    self.postTitle.text="There is supposed to be the post you clicked on + it`s comments\(self.firstname!)"
                }
                return
            }
        }
    }




    @IBAction func buttonClickUps(_ sender: Any){
        if self.upsB.isSelected{
            if let title=self.upsB.currentTitle{
                //100% sure it won`t crash
                self.upsB.setTitle("\((Int(title))!-1)", for: .normal)
            }
        }
        else {
            if let title=self.upsB.currentTitle{
                //100% sure it won`t crash
                self.upsB.setTitle("\((Int(title))!+1)", for: .normal)
            }
        }
        self.upsB.isSelected=(!self.upsB.isSelected)

    }
    @IBAction func buttonClickSave(_ sender: Any){
        saved=(!saved)
        self.savedB.isSelected=saved
    }
}

