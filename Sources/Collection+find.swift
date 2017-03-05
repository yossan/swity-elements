//
//  Collection+find.swift
//  swity-elements
//
//  Created by Kosuke Yoshimoto on 2017/02/19
//  Copyright © 2017 ysn551 All rights reserved.
//

extension Collection where Self.Iterator.Element: Equatable, Self.IndexDistance == Int, Self.Indices.Iterator.Element == Self.Index {

    public func range<C: Collection>(of searchValue: C, in searchRange: Range<Self.Index>? = nil) -> Range<Self.Index>? 
    where C.Iterator.Element == Self.Iterator.Element, C.IndexDistance == Int {
        let searchRange = searchRange ?? self.startIndex..<self.endIndex
        
        guard self.startIndex <= searchRange.lowerBound,
            self.endIndex >= searchRange.upperBound
                else { return nil }

        let from = self.distance(from: self.startIndex, to: searchRange.lowerBound)
        let to = self.distance(from: self.startIndex, to: searchRange.upperBound)
        let length = to - from

        let searchLength = searchValue.distance(from: searchValue.startIndex, to: searchValue.endIndex)

        guard length >= searchLength
            else { return nil }

        var subrange: Range<Self.Index>? = nil
        nextI: for i in from..<(to - (searchLength - 1)) {
            for j in  0..<searchLength {

                let index = self.index(self.startIndex, offsetBy: i+j)
                let searchIndex = searchValue.index(searchValue.startIndex, offsetBy: j)

                let m = self[index]
                let s = searchValue[searchIndex]
                guard m == s else {
                    continue nextI
                }
                if j == searchLength - 1 {
                    subrange = Range(uncheckedBounds: 
                        (lower: self.index(self.startIndex, offsetBy: i),
                         self.index(after: index)))
                    break nextI
                }
            }
        }

        return subrange
    }
}
