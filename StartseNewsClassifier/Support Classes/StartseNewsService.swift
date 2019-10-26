//
//  StartseNewsService.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 26/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import CloudKit

class StartseNewsService {
    var articles:[NewsModel] = []
    
    func loadLatestNews(completion: @escaping ([NewsModel]) -> ()) {
        //Verifica se há novas notícias a serem baixadas do cloudkit
        let database = CKContainer.init(identifier: "iCloud.br.ufpe.cin.StartseNewsClassifier").privateCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "News", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        
        operation.recordFetchedBlock = {
            record in
            
            do {
                let newsFile = record["newsFile"] as! CKAsset
                let decoder = JSONDecoder()
                let json = try Data(contentsOf: newsFile.fileURL!)
                let news = try decoder.decode(NewsModel.self, from: json)
                self.articles.append(news)
            }catch {
                print (error)
            }
        }
        
        operation.queryCompletionBlock = {
            cursor, error in
            
            DispatchQueue.main.async {
                if (error == nil) {
                    print(">>> Finalizou com Sucesso <<<")
                    completion(self.articles)
                }else {
                    print (">>> FINALIZOU QUERY <<<")
                }
            }
        }
        database.add(operation)
    }
}
