//
//  FolderViewController.swift
//  SoundsLyric
//
//  Created by 村松龍之介 on 2017/04/29.
//  Copyright © 2017年 ryunosuke.muramatsu. All rights reserved.
//

import UIKit
import RealmSwift

class FolderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addFolder(_ sender: Any) {
        print("フォルダー追加ボタンが押されました")
        
        // 以下Alertの設定
        // OKアクションを生成
        let defaultAction = UIAlertAction(title: "保存", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            print("保存ボタンが押されました")
            /// テキストが入力されていれば表示
            if let textFields = Const.alertAddFolder.textFields {
                
                // アラートに含まれるすべてのテキストフィールドを調べる
                for textField in textFields {
                    print("「\(textField.text!)」フォルダが追加されました")
                    Const.folders.append(textField.text!)
                    // TableViewを再読み込み.
                    self.tableView.reloadData()
                }
            }
        })
        Const.alertAddFolder.addAction(defaultAction)
        
        // Cancelアクションを生成
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        Const.alertAddFolder.addAction(cancelAction)
        
        // TextFieldを追加
        Const.alertAddFolder.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "名前"
            textField.returnKeyType = .done
        })
        
        // シミュレータの種類によっては、これがないと警告が発生
        Const.alertAddFolder.view.setNeedsLayout()
        // アラートを画面に表示
        self.present(Const.alertAddFolder, animated: true, completion: nil)
        
        // TableViewを再読み込み.
        tableView.reloadData()
    }
    
    @IBAction func editFolder(_ sender: UIBarButtonItem) {
        if isEditing {
            print("（編集の）完了ボタンが押されました")
            super.setEditing(false, animated: true)
            tableView.setEditing(false, animated: true)
            sender.title = "編集"
       } else {
            print("フォルダー編集ボタンが押されました")
            super.setEditing(true, animated: true)
            tableView.setEditing(true, animated: true)
            sender.title = "完了"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSourceプロトコルのメソッド
    // データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.folders.count
    }
    
    /// 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderTableViewCell", for: indexPath)
        cell.textLabel?.text = "\(Const.folders[indexPath.row])"
        return cell
    }
    
    // MARK: UITableViewDelegateプロトコルのメソッド
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // SongListVCに遷移する
        let songListVC = self.storyboard?.instantiateViewController(withIdentifier: "SongListVC") as! SongListViewController
        self.navigationController?.pushViewController(songListVC, animated: true)
        
        // セルの選択を解除する
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            Const.folders.remove(at: indexPath.row)
            
            tableView.reloadData()
        }
    }
    
    // セルの並び替えを有効にする
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
