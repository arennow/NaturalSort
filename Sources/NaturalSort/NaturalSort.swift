import Foundation

extension StringProtocol {
	@inline(__always)
	private func hasCaseInsensitivePrefix<S: StringProtocol>(_ pref: S) -> Bool {
		self.prefix(pref.count).caseInsensitiveCompare(pref) == .orderedSame
	}
	
	internal func sortableBase() -> SubSequence {
		let subst = self.drop(while: { !$0.isLetter && !$0.isNumber })
		
		for pref in ["the ", "an ", "a "] {
			if self.hasCaseInsensitivePrefix(pref) {
				return subst[pref.endIndex...]
			}
		}
		
		return subst
	}
	
	public func naturalCompare<S: StringProtocol>(to other: S) -> Bool {
		self.naturalCompare(to: other) == .orderedAscending
	}
	
	public func naturalCompare<S: StringProtocol>(to other: S) -> ComparisonResult {
		self.sortableBase().compare(other.sortableBase(), options: [.caseInsensitive, .numeric])
	}
}
