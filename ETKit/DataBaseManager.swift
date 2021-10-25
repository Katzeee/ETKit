//
//  DataBaseManager.swift
//  ETKit
//
//  Created by Xi on 2021/10/16.
//

import Foundation
import RealmSwift

class DataBaseManager {
	
	let realm: Realm
	let realmURL: URL
	var currentSchemaVersion: UInt64 = 0
	
	
	
	init() {
		
		
		//配置数据库
		DataBaseManager.InitRealm(userName: "X",
								  schemaVersion: currentSchemaVersion,
								  migrationBlock: { migration,oldSchemaVersion in
			
								})
		//重置所有数据
//		DataBaseManager.DeleteRealmFile()
//		let userDefault = UserDefaults.standard
//		userDefault.set(0, forKey: UserInfo().numbersOfAllWords)
		
		realm = try! Realm()
		realmURL = realm.configuration.fileURL!
		print(realm.configuration.fileURL ?? "")
	}
	
	//MARK: 初始化数据库
	static func InitRealm(userName: String, schemaVersion: UInt64, migrationBlock: @escaping MigrationBlock) -> Void {
		var config = Realm.Configuration()
		
		// Use the default directory, but replace the filename with the username
		config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(userName).realm")
		config.schemaVersion = schemaVersion
		config.migrationBlock = migrationBlock
//		config.migrationBlock = { migration, oldSchemaVersion in
//			if (oldSchemaVersion < schemaVersion) {
//				//do some migration
//			}
//		}
		
		// Set this as the configuration used for the default Realm
		Realm.Configuration.defaultConfiguration = config
		
	}
	
	//MARK: 删除数据库文件
	static func DeleteRealmFile() -> Void {
		
		autoreleasepool {
			// all Realm usage here
		}
		do {
			
			_ = try Realm.deleteFiles(for: Realm.Configuration.defaultConfiguration)
		} catch {
			// handle error
		}
	}
	
}

