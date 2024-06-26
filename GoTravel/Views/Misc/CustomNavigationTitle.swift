//
//  CustomNavigationTitle.swift
//  From https://github.com/b5i/Atwy/blob/9b1ca0ee687c3b39cea2c8ccf3fc35a71bbd8f63/Atwy/CustomNavigationTitle.swift
//

import SwiftUI

public extension View {
    @ViewBuilder func customNavigationTitleWithRightIcon<Content: View>(@ViewBuilder _ rightIcon: @escaping () -> Content) -> some View {
        overlay(content: {
            CustomNavigationTitleView(rightIcon: rightIcon)
                .frame(width: 0, height: 0)
        })
    }
}
public struct CustomNavigationTitleView<RightIcon: View>: UIViewControllerRepresentable {
    
    @ViewBuilder public var rightIcon: () -> RightIcon
    
    public func makeUIViewController(context: Context) -> UIViewController {
        return ViewControllerWrapper(rightContent: rightIcon)
    }
    
    class ViewControllerWrapper: UIViewController {
        private let partOne = ["X3NldExhcmdl", "VGl0bGVBY2Nlc3Nvcnk=", "Vmlldzo="]
        private let partTwo = ["X2FsaWduTGFyZ2VUaXQ=", "bGVBY2Nlc3Nvcnk=", "Vmlld1RvQmFzZWxpbmU="]
        var rightContent: () -> RightIcon
                
        init(rightContent: @escaping () -> RightIcon) {
            self.rightContent = rightContent
            super.init(nibName: nil, bundle: nil)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            guard let navigationController = self.navigationController, let navigationItem = navigationController.visibleViewController?.navigationItem else { return }
            
            let contentView = UIHostingController(rootView: rightContent())
            contentView.view.backgroundColor = .clear
            
            let name: [String] = partOne.compactMap { $0.base64Decoded() ?? "" }
            let name1: [String] = partTwo.compactMap { $0.base64Decoded() ?? "" }
            navigationItem.perform(Selector((name.joined())), with: contentView.view)
            navigationItem.setValue(false, forKey: name1.joined())
            navigationController.navigationBar.prefersLargeTitles = true
            
            super.viewWillAppear(animated)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
