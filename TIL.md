# Today I Learned

- [Swift access level](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)
- [Swift comment documentation](https://nshipster.com/swift-documentation/)
- [inout keyword](https://stackoverflow.com/questions/34486052/when-to-use-inout-parameters)
- [scanf implementaion in c](http://mirror.fsf.org/pmon2000/2.x/src/lib/libc/scanf.c)
- [LLDB command](https://lldb.llvm.org/lldb-gdb.html)
- [indirect keyword]() : enum을 연관형으로 쓸 때 사용
- [convenience keyword]() : init을 다른 종류의 인자로 초기화할 때 사용
- [precondition keyword]()
- Cocoapod update : 
```
// Update podspec version to 'next_version'
git add, commit, push
pod lib lint
git tag 'next_version'
git push --tags
pod trunk --allow-warnings push SwiftTemplateLibrary.podspec
/*
    To resolve message
    [!] The Pod Specification did not pass validation.
    The following validation failed:
    - Warnings: Unrecognized `swift_versions` key.
*/
```
## Implement swifty scanf
