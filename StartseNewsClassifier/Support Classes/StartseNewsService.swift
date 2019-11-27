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
    func giveAllNewsUniqueID(completion: @escaping () -> ()) {
        loadLatestNews() {
            records in
            do {
                let container = CKContainer(identifier: "iCloud.br.ufpe.cin.StartseNewsClassifier")
                try records.forEach {
                    record in
                    let newsModel = try NewsViewModel(record: record)
                    record["id"] = newsModel.id.uuidString.uppercased()
                }
                
                let operation = CKModifyRecordsOperation(recordsToSave: records)
                container.privateCloudDatabase.add(operation)
                
                operation.completionBlock = {
                    completion()
                }
            }catch {
                print("Error: \(error)")
            }
        }
    }
    
    func markAllNewsAsNotClassified(completion: @escaping () -> ()) {
        loadLatestNews() {
            records in

            let container = CKContainer(identifier: "iCloud.br.ufpe.cin.StartseNewsClassifier")

            records.forEach {
                record in
                record["isClassified"] = false
//                container.privateCloudDatabase.save(record) {
//                    record, error in
//
//                    DispatchQueue.main.async {
//                        if (error != nil) {
//                            print ("Error: \(String(describing: error))")
//                        }else {
//                            completion()
//                        }
//                    }
//                }
            }
            let operation = CKModifyRecordsOperation(recordsToSave: records)
            container.privateCloudDatabase.add(operation)
            
            operation.completionBlock = {
                completion()
            }
        }
    }
    
    func loadLatestNews(completion: @escaping ([CKRecord]) -> ()) {
        //Verifica se há novas notícias a serem baixadas do cloudkit
        let database = CKContainer.init(identifier: "iCloud.br.ufpe.cin.StartseNewsClassifier").privateCloudDatabase
        let predicate1 = NSPredicate(format: "isClassified == false")
        
        
        let query = CKQuery(recordType: "News", predicate: predicate1)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 3
        
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
                    print("Error:\(String(describing: error))")
                }
            }
        }
        database.add(operation)
    }
}

extension StartseNewsService {
    func updateNewsAsClassified(classifiedNews:ClassifiedNewsModel, completion: @escaping () -> ()) {
        var recordToUpdateAsClassified:CKRecord?
        
        let newsId = classifiedNews.newsModel.news_id
        let container = CKContainer.init(identifier: "iCloud.br.ufpe.cin.StartseNewsClassifier")
        let database = container.privateCloudDatabase
        let predicate1 = NSPredicate(format: "id == %@", newsId)
        let query = CKQuery(recordType: "News", predicate: predicate1)

        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 1
        
        operation.recordFetchedBlock = {
            record in
            recordToUpdateAsClassified = record
            self.records.append(record)
        }
        
        operation.queryCompletionBlock = {
            cursor, error in
            
            DispatchQueue.main.async {
                if (error == nil) {
                    print(">>> Finalizou com Sucesso <<<")
                    
                    recordToUpdateAsClassified!["isClassified"] = true
                    
                    let updateOperation = CKModifyRecordsOperation(recordsToSave: self.records)
                    database.add(updateOperation)
                    
                    updateOperation.completionBlock = {
                        completion()
                    }
                }else {
                    print (">>> FINALIZOU QUERY <<<")
                    print("Error:\(String(describing: error))")
                }
            }
        }
        database.add(operation)

        
        let sentences = classifiedNews.classifiedSentences
        print(sentences)
    }
}
