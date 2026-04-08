import SwiftUI
import UIKit

struct AlphaHitView: UIViewRepresentable {
    
    let imageName: String
    let onTap: () -> Void
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        let parent: AlphaHitView
        
        init(_ parent: AlphaHitView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let view = sender.view as? UIImageView,
                  let image = view.image else { return }
            
            let location = sender.location(in: view)
            
            if isPixelOpaque(at: location, in: view, image: image) {
                parent.onTap()
            }
        }
        
        func isPixelOpaque(at point: CGPoint, in view: UIImageView, image: UIImage) -> Bool {
            guard let cgImage = image.cgImage else { return false }
            
            let size = view.bounds.size
            
            let x = Int(point.x * CGFloat(cgImage.width) / size.width)
            let y = Int(point.y * CGFloat(cgImage.height) / size.height)
            
            guard x >= 0, y >= 0, x < cgImage.width, y < cgImage.height else { return false }
            
            let pixelData = cgImage.dataProvider?.data
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            
            let bytesPerPixel = 4
            let index = (cgImage.width * y + x) * bytesPerPixel
            
            let alpha = data?[index + 3] ?? 0
            
            return alpha > 10
        }
    }
}
