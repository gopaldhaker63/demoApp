
import Foundation
struct BaseData : Codable {
	let dataRecods : [DataRecods]?

	enum CodingKeys: String, CodingKey {
		case dataRecods = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dataRecods = try values.decodeIfPresent([DataRecods].self, forKey: .dataRecods)
	}
}
