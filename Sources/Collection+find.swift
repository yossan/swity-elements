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
        let mcount = self.count
        let scount = searchValue.count
        guard mcount >= scount else {
            return nil
        }

        var subrange: Range<Self.Index>? = nil
        nextI: for _i in 0..<mcount {
            let i = self.index(self.startIndex, offsetBy: _i)
            guard i >= searchRange.lowerBound, i <= searchRange.upperBound else {
                if i < searchRange.lowerBound {
                    continue
                } else {
                    break
                }
            }

            for j in  0..<scount {

                let mindex = self.index(i, offsetBy: j)
                let sindex = searchValue.index(searchValue.startIndex, offsetBy: j)

                let m = self[mindex]
                let s = searchValue[sindex]
                guard m == s else {
                    continue nextI
                }

                if j == scount - 1 {
                    subrange = Range(uncheckedBounds: (lower: i, upper: self.index(after: mindex)))
                    break nextI
                }
            }
        }

        return subrange
    }
}
