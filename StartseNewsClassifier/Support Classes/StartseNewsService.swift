//
//  StartseNewsService.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 26/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

class StartseNewsService {
    var records:[CKRecord] = []
    
    func loadLatestNews(completion: @escaping ([CKRecord]) -> ()) {
        //Verifica se há novas notícias a serem baixadas do cloudkit
        let database = CKContainer.init(identifier: "iCloud.br.ufpe.cin.StartseNewsClassifier").privateCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "News", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        
        operation.recordFetchedBlock = {
            record in
            self.records.append(record)
        }
        
        operation.queryCompletionBlock = {
            cursor, error in
            
            DispatchQueue.main.async {
                if (error == nil) {
                    print(">>> Finalizou com Sucesso <<<")
                    
                    completion(self.records)
                }else {
                    print (">>> FINALIZOU QUERY <<<")
                }
            }
        }
        database.add(operation)
    }
}
