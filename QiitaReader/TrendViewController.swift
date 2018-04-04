//
//  TrendViewController.swift
//  QiitaReader
//
//  Created by Takuya Matsuda on 2018/03/09.
//  Copyright © 2018年 mycompany. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Nuke

class TrendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
//    var testSearchBar: UISearchBar!
    
    var articles: [Article] = [] //記事を入れるプロパティarticles:構造体の配列
//    var searchResult = [Article]()
    
    //////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        setupSearchBar()
        
        //何も入力されていなくてもReturnキーを押せるようにする。
//        testSearchBar.enablesReturnKeyAutomatically = false
        
        //記事を取得し、tableViewに記録(register)していく
        getArticles()
        self.tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //////////////////////////////////////////////////////////////////////////
    //*各種メソッド                                                          *//
    //////////////////////////////////////////////////////////////////////////
    
    /*JSON型のデータを取得し、structに変換、配列に格納するメソッド*/
    func getArticles() {
        Alamofire.request("https://qiita.com/trend.json").responseJSON { response in
            guard let object = response.result.value else { //guard letで引数responseのvalueプロパティをnil剥がして、定数objectに入れる
                return
            }
            
            let json = JSON(object)["trendItems"] //object（1つの記事）をJSON型に変換？し、定数jsonに入れる
            json.forEach { (_, json) in //JOSN型の定数jsonの各要素をforEachで呼び出し、それらを構造体Articleの引数とし
                let article = Article ( //articleを生成していく
                    title: json["article"]["title"].string!,
                    authorName: json["article"]["author"]["urlName"].string!,
                    authorImageUrl: json["article"]["author"]["profileImageUrl"].string!,
                    goodCnt: json["article"]["likesCount"].int!,
                    tag1: json["article"]["tags"][0]["name"].string,
                    tag2: json["article"]["tags"][1]["name"].string,
                    tag3: json["article"]["tags"][2]["name"].string,
                    url: json["article"]["showUrl"].string!
                )
                self.articles.append(article) //それを辞書の配列であるarticlesに入れていく
            }
            //検索結果配列にデータをコピーする。
//            self.searchResult = self.articles
            self.tableView.reloadData() //TableViewを更新
        }
    }
    
    
    
    
    /*tableViewCellを生成し、値を設定し、そのセルを返すメソッド*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得（生成？）する
        let cell: ArticleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        // セルのプロパティに記事情報を設定する
        let article: Article = articles[indexPath.row]
        cell.title.text = article.title
        cell.author.text = article.authorName
        cell.goodCnt.text = String(article.goodCnt)
        cell.tag1.text = article.tag1
        cell.tag2.text = article.tag2
        cell.tag3.text = article.tag3
        Manager.shared.loadImage(with: URL(string: article.authorImageUrl)!, into: cell.authorIcon)
        return cell
    }
    
    /*TableViewに表示する記事数を返すメソッド*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
//    //検索ボタン押下時の呼び出しメソッド
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        testSearchBar.endEditing(true)
//
//        //検索結果配列を空にする。
//        searchResult.removeAll()
//
//        if(testSearchBar.text == "") {
//            //検索文字列が空の場合はすべてを表示する。
//            searchResult = articles
//        } else {
//            //検索文字列を含むデータを検索結果配列に追加する。
//            for data in articles {
//                if data.title.contains(testSearchBar.text!) {
//                    searchResult.append(data)
//                }
//            }
//        }
//
//        //テーブルを再読み込みする。
//        tableView.reloadData()
//    }
    
    /*記事詳細detailViewに遷移させるメソッド*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.entry = articles[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
//    // MARK: - private methods
//    private func setupSearchBar() {
//        if let navigationBarFrame = navigationController?.navigationBar.bounds {
//            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
//            searchBar.delegate = self
//            searchBar.placeholder = "Search"
//            searchBar.showsCancelButton = true
//            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
//            searchBar.keyboardType = UIKeyboardType.default
//            navigationItem.titleView = searchBar
//            navigationItem.titleView?.frame = searchBar.frame
//            self.testSearchBar = searchBar
//            searchBar.becomeFirstResponder()
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


