//
//  PostTableViewController.swift
//  Levchuk06
//
//  Created by Admin on 15.11.2020.
//

import UIKit

class PostTableViewController: UITableViewController {
    @IBOutlet private weak var subreddit: UILabel!
    private var posts: [ResponsePost]=[]
    var subredditH:String?
    override func viewDidLoad() {
        subredditH="EarthPorn"
        super.viewDidLoad()
        subreddit.text="r/\(subredditH ?? "default")"
        print("hello")
        useCase.fetchTopPosts(subreddit: subredditH ?? "default", limit: 22, after: nil,onCompletion: loadImagePosts(_:))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath ){
  
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyBoard.instantiateViewController(identifier: "ViewController") as! ViewController
        let bufferPost=self.posts[indexPath.row]
        destination.postIdH=bufferPost.id
        destination.titleH=bufferPost.title
        destination.authorH=bufferPost.author
        destination.timeH=bufferPost.timeCreated
        destination.commentsH=bufferPost.numComments
        destination.imageAddressH=bufferPost.imageUrl
        destination.ratingH=bufferPost.ups
        destination.domainH=bufferPost.domain
        destination.subredditH=subredditH ?? "default"
        //navigationController=UIApplication.shared.keyWindow
        navigationController?.pushViewController(destination, animated: true)
    }
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let firstVC = segue.destination as? ViewController else { return }
       // for post in posts:
        firstVC.firstname="\(type(of:((sender as! UIButton).tag.hashValue)))"
        //firstVC.image.sd_setImage(with: URL(string: sender.), placeholderImage: UIImage(named: "placeholder.png"))
    }
 */
func loadImagePosts(_ results: ResponseTop){
    DispatchQueue.main.async{
    for post in results.posts {
    
           // DispatchQueue.main.async{
                self.posts.append(post)
          //
       // print(post.title)
        }
    
        self.tableView.reloadData()
  /*self.yourArray.append(msg)
         
         self.tblView.beginUpdates()
         self.tblView.insertRows(at: [IndexPath.init(row: self.yourArray.count-1, section: 0)], with: .automatic)
         self.tblView.endUpdates()*/
    }
}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as! PostTableViewCell

        // Configure the cell...
        cell.configure(for: posts[indexPath.row])
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
