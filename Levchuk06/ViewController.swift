//
//  ViewController.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//
import SwiftUI
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
    @IBOutlet weak var commentsContainer: UIView!
    var subredditH:String?
    var postIdH: String?
    var authorH: String?
    var titleH: String?
    var timeH: Double?
    var domainH: String?
    var imageAddressH: String?
    var commentsH: Int?
    var ratingH: Int?
    private var saved: Bool=false
    override func viewDidLoad() {
        super.viewDidLoad()
 loadInfo()
        let childView = UIHostingController(rootView: ContentView(subreddit: subredditH ?? "default", postId: postIdH ?? "default"))
        print(subredditH)
        print(postIdH)
              addChild(childView)
        childView.view.frame = commentsContainer.bounds
        commentsContainer.addSubview(childView.view)
              childView.didMove(toParent: self)
        shareB.addTarget(self,
                               action: #selector(shareBClicked),
                               for: .touchUpInside)

    }
    func loadInfo(){
        DispatchQueue.main.async{
            self.name.text="u/\(self.authorH ?? "default_author")"
            let date = NSDate(timeIntervalSince1970: self.timeH ?? 0)
            self.time.text=" \(Calendar.current.dateComponents([.hour], from: date as Date, to: NSDate() as Date).hour!) hrs"
            self.domain.text=self.domainH ?? "default_domain"
            self.postTitle.text=self.titleH ?? "default_title"
            self.image.sd_setImage(with: URL(string: self.imageAddressH ?? "lol"), placeholderImage: UIImage(named: "placeholder.png"))
            self.upsB.setTitle("\(self.ratingH ?? 0)", for: .normal)
            self.commentsB.setTitle("\(self.commentsH ?? 0)", for: .normal)
        
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
    
    @objc func shareBClicked(){
        guard let data = URL(string: "https://www.reddit.com/r/\(self.subredditH ?? "default")/comments/\(self.postIdH ?? "default")") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
     
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
        print("Shared")
    }
    
}

