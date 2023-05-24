//
//  Model.swift
//  Models
//
//  Created by DA MAC M1 135 on 2023/05/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let toDo = try? JSONDecoder().decode(ToDo.self, from: jsonData)

// MARK: This is the model/interface

import Foundation

// MARK: - ToDo
struct ToDo: Codable {
	var userId: Int
	var id: Int
	var title: String
	var completed: Bool

	enum CodingKeys: String, CodingKey {
		case userId = "userId"
		case id = "id"
		case title = "title"
		case completed = "completed"
	}
}
