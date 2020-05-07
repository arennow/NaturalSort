import Foundation

extension StringProtocol {
	@inline(__always)
	private func hasCaseInsensitivePrefix<S: StringProtocol>(_ pref: S) -> Bool {
		self.prefix(pref.count).caseInsensitiveCompare(pref) == .orderedSame
	}
	
	internal func sortableBase() -> SubSequence {
		for pref in ["the ", "an ", "a "] {
			if self.hasCaseInsensitivePrefix(pref) {
				return self[pref.endIndex...]
			}
		}
		
		return self[...]
	}
	
	public func naturalCompare<S: StringProtocol>(to other: S) -> Bool {
		self.sortableBase().compare(other.sortableBase(), options: [.caseInsensitive, .numeric]) == .orderedAscending
	}
}
