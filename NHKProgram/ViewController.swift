//
//  ViewController.swift
//  NHKproject
//
//  Created by cmStudent on 2020/08/11.
//  Copyright © 2020 20CM0103. All rights reserved.
//

//　2022/11/24　テスト

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let prop = NHKProperties.shared.prop
    //APIからJSONで帰ってくる1軒分のデータ(オプショナルで宣言)
    var nhkprogramList: NHKProgramResponce? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        //Table ViewのdataSourceを設定
        tableView.dataSource = self
        //tableのカスタムを設定
        tableView.register(UINib(nibName: "NHKProgramCell", bundle: nil), forCellReuseIdentifier: "ProgramCustomCell")
        //tableviewの高さ
        tableView.rowHeight = 120
        
        //let baseUrlString = "https://api.nhk.or.jp/v2/pg/"
        // let program = "list/"
        //リクエストURLを作成
        let area = "130/"
        let service = "g1/"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: Date())
        
        print(Date())
        
        //        let formatter2 = DateFormatter()
        //        formatter2.dateFormat = "yyyy-MM-dd HH:mm"
        //        let date2 = formatter.string(from: Date())
        //        print(date2)
        
        //let urlString =  baseUrlString + program + area + service + date + ".json?key=hgH8ilWqLQwBZSukmLuLtrH0a1Z38YAe"
        var urlString = (prop["NHKProgramURL"] ?? "")
        urlString += (prop["ProgramList"] ?? "")
        urlString += area
        urlString += service
        urlString += date
        urlString += ".json"
        
        let url = URL(string: urlString)!
        
        let parameters = ["key" : prop["ApiKey"] ?? ""]
        //guardはエラーを防ぐためのもの？
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: nil != url.baseURL) else {
            return
        }
        //複数のリクエストパラメタをまとめてURLQueryの配列に変換
        components.queryItems = parameters.map({ (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: String(value))
        })
        
        //let semaphore = DispatchSemaphore(value: 0)
        
        
        //let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: components.url!, completionHandler:  { (data, response, error) in
            if error != nil {
                print("情報の取得に失敗した：", error!)
                return
            }
            if let data = data {
                do {
                    self.nhkprogramList = try
                        JSONDecoder().decode(NHKProgramResponce.self, from: data)
                    print(self.nhkprogramList!)
                } catch(let err) {
                    print("JSONDEcoderエラー：", err)
                }
                //UI処理はメインっすれっどで実行(クロージャーが別スレッドで動いているため)
                DispatchQueue.main.async{
                    self.tableView.reloadData() //tableView再描画
                }
            }
            
        })
        //URL Sessionのタスクを実行
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let g1 = nhkprogramList?.list.g1{
            return g1.count
        } else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //今回表示を行う、Cellオブジェクト(1桁)を取得します (今回はカスタムセル)
        let Cell = tableView.dequeueReusableCell(withIdentifier: "ProgramCustomCell", for: indexPath) as! NHKProgramCell
        //        //番組のタイトル設定
        if let g1 = nhkprogramList?.list.g1 {
            let contents = g1[indexPath.row]
            Cell.programTitleLavel.text = contents.title
            Cell.programSubtitleLavel.text = contents.subtitle
            
            let date = ISO8601DateFormatter().date(from: contents.start_time)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            Cell.programStertLaval.text = formatter.string(from: date!)
            //画像のURLを取得
            let urlString = "https:" + contents.service.logo_s.url
            if let url = URL(string: urlString) {
                if let imagedata = try? Data(contentsOf: url) {
                    Cell.serviceLogoimage.image = UIImage(data: imagedata)
                } else {
                    print("ロゴ画像データを取得できない")
                }
            } else {
                Cell.programSubtitleLavel.text = "レストンす待ち or 通信エラー"
            }
            
        }
        
        //        Cell.textLabel?.text = nhkprogramList?.list.g1[indexPath.row].title        //        //お菓子がぞうを取得
        //        if let imageData = try? Data(contentsOf: nhkprogramList?.list.g1[indexPath.row].service.logo_m.url) {
        //                 //正常に取得できた場合は、UIImageで画像オブジェクトを生成して、Callにお菓子がぞうを設定
        //                 Cell.imageView?.image = UIImage(data: imageData)
        //               }
        //設定ずみのCellオブジェクトを画像に反映
        return Cell
    }
    
    
}

